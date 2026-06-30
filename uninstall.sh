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
	echo "Uninstall dotfiles using GNU Stow"
	echo ""
	echo "Options:"
	echo "  -h, --help      Show this help message"
	echo "  -v, --verbose   Enable verbose output"
	echo ""
	echo "Available modules:"
	echo "  ${modules[*]}"
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

# Unstow a module
unstow_module() {
	local module_name="$1"
	local target_dir
	target_dir=$(get_target_dir "$module_name")
	echo -e "Unstowing ${BOLD}${RED}$module_name${NC} from target at ${BLUE}${target_dir}${NC}"
	stow -v -D -t "$target_dir" "$module_name"
}

# Unstow all modules
unstow_all() {
	for module in "${modules[@]}"; do
		unstow_module "$module"
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

	print_banner
	echo -e "Available modules: ${YELLOW}${modules[*]}${NC}"
	echo -e "${BOLD}Starting uninstallation of stow modules...${NC}"
	echo -e "\n"

	# Check if specific modules were requested
	if [ ${#selected_modules[@]} -eq 0 ]; then
		echo -e "${CYAN}Uninstalling all modules...${NC}"
		unstow_all
	else
		debug "Input modules: ${selected_modules[*]}"
		validate_selected_modules
		# Uninstall specified modules
		for module in "${selected_modules[@]}"; do
			debug "Processing module: $module"
			unstow_module "$module"
		done
	fi

	echo -e "\n${GREEN}${BOLD}Uninstallation of stow modules complete!${NC}"
}

# Execute main function
main "$@"
