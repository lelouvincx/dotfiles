#!/bin/bash

# sqlfix - A helper script for running SQLFluff against dbt models
# Save this file as 'sqlfix' in a directory in your PATH (e.g., ~/bin/ or /usr/local/bin/)
# Make it executable with: chmod +x sqlfix

# Print usage information
print_usage() {
	echo "SQLFluff Helper - Run fix and lint on dbt SQL models"
	echo
	echo "Usage: sqlfix [options] <model_paths>"
	echo
	echo "Options:"
	echo "  -h, --help     Show this help message"
	echo "  -l, --lint     Only run lint (skip fix)"
	echo "  -f, --fix      Only run fix (skip lint)"
	echo "  -v, --verbose  Show more detailed output"
	echo
	echo "Examples:"
	echo "  sqlfix models/marts/core/dim_customers.sql"
	echo "  sqlfix models/marts/core/"
	echo "  sqlfix --lint models/marts/finance/"
	echo "  sqlfix -f models/staging/"
}

# Default options
RUN_FIX=true
RUN_LINT=false
VERBOSE=false

# Parse command line options
PARAMS=()
while (("$#")); do
	case "$1" in
	-h | --help)
		print_usage
		exit 0
		;;
	-l | --lint)
		RUN_FIX=false
		RUN_LINT=true
		shift
		;;
	-f | --fix)
		RUN_FIX=true
		RUN_LINT=false
		shift
		;;
	-v | --verbose)
		VERBOSE=true
		shift
		;;
	--) # End of options
		shift
		break
		;;
	-*) # Unknown option
		echo "Error: Unknown option: $1" >&2
		print_usage
		exit 1
		;;
	*) # Preserve positional arguments
		PARAMS+=("$1")
		shift
		;;
	esac
done

# Set positional arguments in their proper place
set -- "${PARAMS[@]}"

# Check if model paths are provided
if [ $# -eq 0 ]; then
	echo "Error: No model paths provided" >&2
	print_usage
	exit 1
fi

# Common SQLFluff options
SQLFLUFF_COMMON="--templater=dbt --verbose"

# Function to run SQLFluff commands
run_sqlfluff() {
	local command=$1
	local paths=("${@:2}")

	if [ "$VERBOSE" = true ]; then
		echo "Running: sqlfluff $command $SQLFLUFF_COMMON ${paths[*]}"
	fi

	if [ "$command" = "fix" ]; then
		sqlfluff fix $SQLFLUFF_COMMON "${paths[@]}"
	elif [ "$command" = "lint" ]; then
		sqlfluff lint $SQLFLUFF_COMMON --nofail "${paths[@]}"
	fi
}

# Run the commands
if [ "$RUN_FIX" = true ]; then
	echo "🔧 Running SQLFluff fix..."
	run_sqlfluff "fix" "$@"
fi

if [ "$RUN_LINT" = true ]; then
	echo "🔍 Running SQLFluff lint..."
	run_sqlfluff "lint" "$@"
fi

echo "✅ SQLFluff processing complete!"
