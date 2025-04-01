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

# Parse command line arguments
for arg in "$@"; do
	if [[ "$arg" == "-v" || "$arg" == "--verbose" ]]; then
		VERBOSE=1
		# Remove the verbose argument from the arguments list
		set -- "${@/$arg/}"
	fi
done

# Debug function
debug() {
	if [[ $VERBOSE -eq 1 ]]; then
		echo -e "${CYAN}[DEBUG]${NC} $1"
	fi
}

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

# Define modules and their targets
modules=("zshrc" "tmux" "alacritty" "nvim" "local" "mise" "spaceship")

# Get target directory for a module
get_target_dir() {
	local module="$1"
	case "$module" in
	"zshrc" | "local" | "spaceship")
		echo "$HOME_DIR"
		;;
	"tmux" | "alacritty" | "nvim" | "mise")
		echo "$CONFIG_DIR"
		;;
	*)
		echo "$HOME_DIR" # Default to home directory
		;;
	esac
}

# Check if module exists
module_exists() {
	local module="$1"
	for m in "${modules[@]}"; do
		if [[ "$m" == "$module" ]]; then
			return 0
		fi
	done
	return 1
}

# Stow a module
stow_module() {
	local module_name="$1"
	local target_dir=$(get_target_dir "$module_name")

	echo -e "Stowing ${BOLD}${GREEN}$module_name${NC} to target at ${BLUE}${target_dir}${NC}"
	stow -v -t "$target_dir" "$module_name"
}

# Stow all modules
stow_all() {
	for module in "${modules[@]}"; do
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
	print_banner

	echo -e "Available modules: ${YELLOW}${modules[*]}${NC}"
	echo -e "${BOLD}Starting installation of stow modules...${NC}"
	echo -e "\n"

	# Check if specific modules were requested
	if [ $# -eq 0 ]; then
		echo -e "${CYAN}Installing all modules...${NC}"
		stow_all
	else
		debug "Input arguments: $@"
		# Install specified modules
		for module in "$@"; do
			debug "Processing module: $module"
			if module_exists "$module"; then
				debug "Module '$module' exists in the list."
				stow_module "$module"
			else
				debug "Module '$module' does not exist in the list."
				echo -e "${RED}Module '$module' is not recognized. Please check the available modules.${NC}"
			fi
		done
	fi

	echo -e "\n${GREEN}${BOLD}Installation stow modules complete!${NC}"
}

# Execute main function
main "$@"
