#!/usr/bin/env bash
set -e

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Variables and defaults
VERBOSE=0
CONFIG_DIR="${HOME}/.config"
HOME_DIR="${HOME}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
selected_modules=()

# Define modules and their targets
# shellcheck source=scripts/stow-modules.sh
source "${SCRIPT_DIR}/scripts/stow-modules.sh"

# Show help message
show_help() {
	echo "Usage: $0 [OPTIONS] [MODULES...]"
	echo ""
	echo "Install dotfiles using GNU Stow"
	echo ""
	echo "Options:"
	echo "  -h, --help      Show this help message"
	echo "  -v, --verbose   Enable verbose output"
	echo ""
	echo "Available modules:"
	echo "  ${modules[*]}"
	echo ""
	echo "Examples:"
	echo "  $0                    # Install all modules"
	echo "  $0 nvim tmux          # Install only nvim and tmux"
	echo "  $0 -v alacritty       # Install alacritty with verbose output"
}

# Parse command line arguments
parse_args() {
	while [[ $# -gt 0 ]]; do
		case "$1" in
		-h | --help)
			show_help
			exit 0
			;;
		-v | --verbose)
			VERBOSE=1
			;;
		--)
			shift
			selected_modules+=("$@")
			break
			;;
		-*)
			echo -e "${RED}Unknown option: $1${NC}" >&2
			show_help >&2
			exit 1
			;;
		*)
			selected_modules+=("$1")
			;;
		esac
		shift
	done
}

# Debug function
debug() {
	if [[ $VERBOSE -eq 1 ]]; then
		echo -e "${CYAN}[DEBUG]${NC} $1"
	fi
}

validate_selected_modules() {
	local module
	for module in "${selected_modules[@]}"; do
		if ! module_exists "$module"; then
			echo -e "${RED}Module '$module' is not recognized. Please check the available modules.${NC}" >&2
			exit 1
		fi
	done
}

# Stow a module
stow_module() {
	local module_name="$1"
	local target_dir
	target_dir=$(get_target_dir "$module_name")

	echo -e "Stowing ${BOLD}${GREEN}$module_name${NC} to target at ${BLUE}${target_dir}${NC}"
	if ! stow -R -v -t "$target_dir" "$module_name" 2>&1; then
		echo -e "${RED}Error: Stowing module '$module_name' failed${NC}"
		echo -e "${YELLOW}Try ./install.sh -v to see the error message${NC}"
		return 1
	fi
}

# Show progress
show_progress() {
	local current=$1
	local total=$2
	local module=$3
	echo -e "${BOLD}[$current/$total]${NC} Processing ${CYAN}$module${NC}..."
}

# Stow all modules
stow_all() {
	local total=${#modules[@]}
	local current=0

	for module in "${modules[@]}"; do
		((++current))
		show_progress $current $total "$module"
		stow_module "$module"
	done
}

# Print banner
print_banner() {
	echo -e "\n"
	echo -e "${MAGENTA}  ██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗${NC}"
	echo -e "${MAGENTA}  ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝${NC}"
	echo -e "${MAGENTA}  ██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗${NC}"
	echo -e "${MAGENTA}  ██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║${NC}"
	echo -e "${MAGENTA}  ██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║${NC}"
	echo -e "${MAGENTA}  ╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝${NC}"
	echo -e "                                                               "
	echo -e "\n"
}

# Main function
main() {
	parse_args "$@"

	# Check for GNU Stow
	if ! command -v stow &>/dev/null; then
		echo -e "${RED}${BOLD}Error:${NC} GNU Stow is not installed. Please install it to proceed."
		echo -e "${YELLOW}On MacOS:${NC} brew install stow"
		echo -e "${YELLOW}On Ubuntu/Debian:${NC} sudo apt install stow"
		echo -e "${YELLOW}On Fedora/RHEL:${NC} sudo dnf/yum install stow"
		exit 1
	fi

	# Create necessary directories
	mkdir -p "${CONFIG_DIR}"
	mkdir -p "${HOME}/.local/bin"

	print_banner

	echo -e "Available modules: ${YELLOW}${modules[*]}${NC}"
	echo -e "${BOLD}Starting installation of stow modules...${NC}"
	echo -e "\n"

	# Check if specific modules were requested
	if [ ${#selected_modules[@]} -eq 0 ]; then
		echo -e "${CYAN}Installing all modules...${NC}"
		stow_all
	else
		debug "Input modules: ${selected_modules[*]}"
		validate_selected_modules
		# Install specified modules
		local total=${#selected_modules[@]}
		local current=0

		for module in "${selected_modules[@]}"; do
			((++current))
			debug "Processing module: $module"
			show_progress $current $total "$module"
			stow_module "$module"
		done
	fi

	echo -e "\n${GREEN}${BOLD}Installation stow modules complete!${NC}"
}

# Execute main function
main "$@"
