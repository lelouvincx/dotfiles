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

# Create necessary directories for configuration files
mkdir -p ~/.config
mkdir -p ~/.local/bin

modules=("zsh", "tmux", "alacritty", "nvim", "local")

stow_module() {
	echo "Stowing $1 to target at ${HOME}..."
	stow -v -t ~ "$1"
}

stow_all() {
	for module in "${modules[@]}"; do
		stow_module "$module"
	done
}

# Main installation function
echo "Starting installation of stow modules..."
echo "Available modules: ${modules[*]}"

# Check if specific modules were requested
if [ $# -eq 0 ]; then
	echo "Installing all modules..."
	install_all
else
	# Install specified modules
	for module in "$@"; do
		if [[ " ${modules[*]} " =~ " ${module} " ]]; then
			stow_module "$module"
		else
			echo "Unknown module: $module"
			echo "Available modules: ${modules[*]}"
		fi
	done
fi

echo "Installation stow modules complete!"
