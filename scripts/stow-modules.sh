#!/usr/bin/env bash

# Shared module list and targets for install.sh and uninstall.sh.
modules=("zshrc" "tmux" "alacritty" "nvim" "local" "mise" "spaceship" "bat" "herdr")

get_target_dir() {
	local module="$1"
	case "$module" in
	"zshrc" | "tmux" | "local" | "spaceship")
		echo "$HOME_DIR"
		;;
	"alacritty" | "nvim" | "mise" | "bat" | "herdr")
		echo "$CONFIG_DIR"
		;;
	*)
		return 1
		;;
	esac
}

module_exists() {
	local module="$1"
	for m in "${modules[@]}"; do
		if [[ "$m" == "$module" ]]; then
			return 0
		fi
	done
	return 1
}
