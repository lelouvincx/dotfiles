#!/bin/bash

# sqlfix - A helper script for running SQLFluff against dbt models with charmbracelet/gum
# Dependencies: gum, sqlfluff, uv
# Save this as 'sqlfix' in a directory in your PATH (e.g., ~/bin/)
# Make it executable with: chmod +x sqlfix

# Check if gum is installed
if ! command -v gum &>/dev/null; then
	echo "Error: gum is not installed. Please install it from https://github.com/charmbracelet/gum"
	exit 1
fi

# Print usage with gum styling
print_usage() {
	gum style --border normal --margin "1" --padding "1 2" --border-foreground 212 "
$(gum style --foreground 212 --bold 'SQLFluff Helper')
A tool for running SQLFluff against dbt SQL models

$(gum style --foreground 99 --bold 'Usage:')
  sqlfix [options] <model_paths>

$(gum style --foreground 99 --bold 'Options:')
  $(gum style --foreground 159 '-h, --help')     Show this help message
  $(gum style --foreground 159 '-l, --lint')     Only run lint (skip fix)
  $(gum style --foreground 159 '-f, --fix')      Only run fix (skip lint)

$(gum style --foreground 99 --bold 'Examples:')
  sqlfix models/marts/core/dim_customers.sql
  sqlfix models/marts/core/
  sqlfix --lint models/marts/finance/
  sqlfix -f models/staging/
"
}

RUN_FIX=true
RUN_LINT=false
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
	--) # End of options
		shift
		break
		;;
	-*) # Unknown option
		gum style --foreground 210 "Error: Unknown option: $1"
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

# If no arguments provided, suggest file picker
if [ $# -eq 0 ]; then
	gum style --foreground 214 "No model paths provided. Select files or directories:"
	PICKED=$(gum file --file --directory)
	if [ -z "$PICKED" ]; then
		gum style --foreground 210 "No files selected. Exiting."
		exit 1
	fi
	set -- "$PICKED"
fi

# Show what actions will be performed
ACTIONS=""
if [ "$RUN_FIX" = true ]; then
	ACTIONS+="Fix"
fi
if [ "$RUN_FIX" = true ] && [ "$RUN_LINT" = true ]; then
	ACTIONS+=" and "
fi
if [ "$RUN_LINT" = true ]; then
	ACTIONS+="Lint"
fi

gum style --foreground 140 "🔍 About to run $(gum style --bold "$ACTIONS") on: $(gum style --bold "$*")"

# Confirm
if ! gum confirm "Proceed?"; then
	gum style --foreground 210 "Operation cancelled."
	exit 0
fi

# Common SQLFluff options
SQLFLUFF_COMMON="--templater=dbt --verbose"

# Run fix if requested
if [ "$RUN_FIX" = true ]; then
	gum style --foreground 104 "🔧 Running SQLFluff fix..."
	gum spin --spinner dot --title "Running fix..." --show-output --show-error -- sqlfluff fix $SQLFLUFF_COMMON "$@"
	FIX_STATUS=$?
	if [ $FIX_STATUS -eq 0 ]; then
		gum style --foreground 86 "✓ Fix completed successfully"
	else
		gum style --foreground 210 "⚠ Fix completed with issues (status: $FIX_STATUS)"
	fi
fi

# Run lint if requested
if [ "$RUN_LINT" = true ]; then
	gum style --foreground 104 "🔍 Running SQLFluff lint..."
	gum spin --spinner dot --title "Running lint..." --show-output --show-error -- sqlfluff lint $SQLFLUFF_COMMON --nofail "$@"
	LINT_STATUS=$?

	if [ $LINT_STATUS -eq 0 ]; then
		gum style --foreground 86 "✓ No linting issues found"
	else
		gum style --foreground 214 "⚠ Found linting issues"
	fi
fi

# Final status
gum style --border normal --border-foreground 86 --margin "1" --padding "0 1" "$(gum style --foreground 86 --bold "✅ SQLFluff processing complete!")"
