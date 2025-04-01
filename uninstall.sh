#!/usr/bin/env bash
set -e

# Check for GNU Stow exists
if ! command -v stow &>/dev/null; then
	echo "GNU Stow is not installed. Please install it to proceed."
	echo "On MacOS: brew install stow"
	echo "On Ubuntu/Debian: sudo apt install stow"
	echo "On Fedora/RHEL: sudo dnf/yum install stow"
	exit 1
fi

modules=("zshrc" "tmux" "alacritty" "nvim" "local" "mise" "spaceship")

unstow_module() {
	echo "Unstowing $1 from target at ${HOME}"
	stow -v -D -t ~/.config "$1"
}

unstow_all() {
	for module in "${modules[@]}"; do
		unstow_module "$module"
	done
}

# Main uninstallation function
echo -e "\n"
echo -e "  ██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗"
echo -e "  ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝"
echo -e "  ██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗"
echo -e "  ██║  ██║██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║"
echo -e "  ██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║"
echo -e "  ╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝"
echo -e "                                                               "
echo -e "\n"
echo "Available modules: ${modules[*]}"
echo "Starting uninstallation of stow modules..."
echo -e "\n"

# Check if specific modules were requested
if [ $# -eq 0 ]; then
	echo "Uninstalling all modules..."
	unstow_all
	echo "Uninstallation of stow modules complete!"
else
	# Uninstall specified modules
	for module in "$@"; do
		if [[ " ${modules[*]} " =~ " ${module} " ]]; then
			unstow_module "$module"
		else
			echo "Module '$module' is not recognized. Please check the available modules."
		fi
	done
	echo "Uninstallation of stow modules complete!"
fi
