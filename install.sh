#!/usr/bin/env bash

set -e

VERBOSE=0

for arg in "$@"; do
	if [[ "$arg" == "-v" || "$arg" == "--verbose" ]]; then
		VERBOSE=1
		# Remove the verbose argument from the arguments list
		set -- "${@/$arg/}"
	fi
done

debug() {
	if [[ $VERBOSE -eq 1 ]]; then
		echo "[DEBUG] $1"
	fi
}

# Check for GNU Stow exists
if ! command -v stow &>/dev/null; then
	echo "GNU Stow is not installed. Please install it to proceed."
	echo "On MacOS: brew install stow"
	echo "On Ubuntu/Debian: sudo apt install stow"
	echo "On Fedora/RHEL: sudo dnf/yum install stow"
	exit 1
fi

# Create necessary directories for configuration files
mkdir -p ~/.config
mkdir -p ~/.local/bin

modules=("zshrc" "tmux" "alacritty" "nvim" "local" "mise" "spaceship")

module_exists() {
	local module="$1"
	for m in "${modules[@]}"; do
		debug "Comparing '$module' with '$m'"
		if [[ "$m" == "$module" ]]; then
			return 0
		fi
	done
	return 1
}

stow_module() {
	local module_name="$1"

	echo "Stowing $module_name to target at ${HOME}/.config"
	stow -v -t ~/.config "$module_name"
}

stow_all() {
	for module in "${modules[@]}"; do
		stow_module "$module"
	done
}

# Main installation function
echo -e "\n"
echo -e "  ██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗"
echo -e "  ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝"
echo -e "  ██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗"
echo -e "  ██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║"
echo -e "  ██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║"
echo -e "  ╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝"
echo -e "                                                               "
echo -e "\n"
echo "Available modules: ${modules[*]}"

echo "Starting installation of stow modules..."
echo -e "\n"

# Check if specific modules were requested
if [ $# -eq 0 ]; then
	echo "Installing all modules..."
	stow_all
	echo "Installation stow modules complete!"
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
			echo "Module '$module' is not recognized. Please check the available modules."
		fi
	done

fi
