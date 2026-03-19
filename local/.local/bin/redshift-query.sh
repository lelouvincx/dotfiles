#!/bin/bash
set -e

# Redshift Data API query wrapper
# Usage: redshift-query.sh [-c cluster] [-d database] [-u user] [-s secret-arn] [-i interval] "SQL"

CLUSTER_ID="${REDSHIFT_CLUSTER_ID:-}"
DATABASE="${REDSHIFT_DATABASE:-dev}"
DB_USER="${REDSHIFT_DB_USER:-}"
SECRET_ARN="${REDSHIFT_SECRET_ARN:-}"
POLL_INTERVAL=2
OUTPUT_FORMAT="markdown"  # markdown, json, csv

usage() {
    cat <<EOF
Usage: $(basename "$0") [options] "SQL query"

Options:
    -c CLUSTER    Cluster identifier (or set REDSHIFT_CLUSTER_ID)
    -d DATABASE   Database name (default: dev, or set REDSHIFT_DATABASE)
    -u USER       Database user (or set REDSHIFT_DB_USER)
    -s SECRET     AWS Secrets Manager ARN (or set REDSHIFT_SECRET_ARN)
    -i INTERVAL   Poll interval in seconds (default: 2)
    -f FORMAT     Output format: markdown (default), json, csv
    -h            Show this help

Examples:
    $(basename "$0") -c my-cluster -u awsuser "select * from users limit 10"
    $(basename "$0") -f csv -c my-cluster -u awsuser "select * from users"
    $(basename "$0") -s arn:aws:secretsmanager:... "select count(*) from orders"
EOF
    exit 1
}

while getopts "c:d:u:s:i:f:h" opt; do
    case $opt in
        c) CLUSTER_ID="$OPTARG" ;;
        d) DATABASE="$OPTARG" ;;
        u) DB_USER="$OPTARG" ;;
        s) SECRET_ARN="$OPTARG" ;;
        i) POLL_INTERVAL="$OPTARG" ;;
        f) OUTPUT_FORMAT="$OPTARG" ;;
        h) usage ;;
        *) usage ;;
    esac
done
shift $((OPTIND - 1))

QUERY="$1"
[[ -z "$QUERY" ]] && { echo "Error: SQL query required"; usage; }
[[ -z "$CLUSTER_ID" ]] && { echo "Error: Cluster identifier required (-c or REDSHIFT_CLUSTER_ID)"; exit 1; }
[[ -z "$DB_USER" && -z "$SECRET_ARN" ]] && { echo "Error: Either -u (user) or -s (secret-arn) required"; exit 1; }

command -v jq >/dev/null 2>&1 || { echo "Error: jq is required"; exit 1; }

# Build auth args
AUTH_ARGS=()
if [[ -n "$SECRET_ARN" ]]; then
    AUTH_ARGS+=(--secret-arn "$SECRET_ARN")
else
    AUTH_ARGS+=(--db-user "$DB_USER")
fi

echo "Submitting query to Redshift..." >&2

# 1. Execute statement
EXEC_RES=$(aws redshift-data execute-statement \
    --cluster-identifier "$CLUSTER_ID" \
    --database "$DATABASE" \
    "${AUTH_ARGS[@]}" \
    --sql "$QUERY")

STMT_ID=$(echo "$EXEC_RES" | jq -r '.Id')
echo "Statement ID: $STMT_ID" >&2

# 2. Poll for completion
echo -n "Executing" >&2
while true; do
    DESC_RES=$(aws redshift-data describe-statement --id "$STMT_ID")
    STATUS=$(echo "$DESC_RES" | jq -r '.Status')

    case "$STATUS" in
        FINISHED)
            echo -e "\nQuery finished!" >&2
            break
            ;;
        FAILED|ABORTED)
            echo -e "\nQuery $STATUS" >&2
            echo "$DESC_RES" | jq -r '.Error' >&2
            exit 1
            ;;
        *)
            echo -n "." >&2
            sleep "$POLL_INTERVAL"
            ;;
    esac
done

# 3. Get results (with pagination)
ALL_RESULTS=""
COLUMNS=""
NEXT_TOKEN=""

while true; do
    if [[ -z "$NEXT_TOKEN" ]]; then
        RESULT=$(aws redshift-data get-statement-result --id "$STMT_ID")
    else
        RESULT=$(aws redshift-data get-statement-result --id "$STMT_ID" --next-token "$NEXT_TOKEN")
    fi

    if [[ -z "$COLUMNS" ]]; then
        COLUMNS=$(echo "$RESULT" | jq -r '[.ColumnMetadata[].name] | @json')
    fi

    ALL_RESULTS+=$(echo "$RESULT" | jq -c '.Records[]')
    ALL_RESULTS+=$'\n'

    NEXT_TOKEN=$(echo "$RESULT" | jq -r '.NextToken // empty')
    [[ -z "$NEXT_TOKEN" ]] && break
done

format_value() {
    local field="$1"
    echo "$field" | jq -r 'to_entries[0].value // ""'
}

format_markdown() {
    local cols="$1"
    local records="$2"

    col_names=$(echo "$cols" | jq -r '.[]')
    col_count=$(echo "$cols" | jq 'length')

    header="| "
    separator="| "
    for name in $col_names; do
        header+="$name | "
        separator+="--- | "
    done
    echo "$header"
    echo "$separator"

    echo "$records" | while IFS= read -r row; do
        [[ -z "$row" ]] && continue
        line="| "
        for ((i=0; i<col_count; i++)); do
            val=$(echo "$row" | jq -r ".[$i] | to_entries[0].value // \"\"")
            line+="$val | "
        done
        echo "$line"
    done
}

format_csv() {
    local cols="$1"
    local records="$2"

    echo "$cols" | jq -r '. | @csv'

    echo "$records" | while IFS= read -r row; do
        [[ -z "$row" ]] && continue
        echo "$row" | jq -r '[.[] | to_entries[0].value // ""] | @csv'
    done
}

format_json() {
    local cols="$1"
    local records="$2"

    echo "$records" | while IFS= read -r row; do
        [[ -z "$row" ]] && continue
        echo "$row" | jq -c --argjson cols "$cols" '
            [to_entries | .[] | {key: $cols[.key], value: .value | to_entries[0].value}]
            | from_entries
        '
    done | jq -s '.'
}

case "$OUTPUT_FORMAT" in
    markdown|md)
        format_markdown "$COLUMNS" "$ALL_RESULTS"
        ;;
    csv)
        format_csv "$COLUMNS" "$ALL_RESULTS"
        ;;
    json)
        format_json "$COLUMNS" "$ALL_RESULTS"
        ;;
    *)
        echo "Unknown format: $OUTPUT_FORMAT" >&2
        exit 1
        ;;
esac
