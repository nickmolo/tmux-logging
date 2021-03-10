#!/usr/bin/env bash
# shellcheck source=variables.sh

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$CURRENT_DIR/variables.sh"
source "$CURRENT_DIR/shared.sh"

# returns a string unique to current pane
pane_unique_id() {
	tmux display-message -p "#{session_name}_#{window_index}_#{pane_index}"
}

# this function checks if logging is happening for the current pane
is_logging() {
	local pane_unique_id
	pane_unique_id="$(pane_unique_id)"
	local current_pane_logging
	current_pane_logging="$(get_tmux_option "@${pane_unique_id}" "not logging")"
	if [ "$current_pane_logging" == "logging" ]; then
		return 0
	else
		return 1
	fi
}


main() {
	if supported_tmux_version_ok; then
		if is_logging; then
			display_message "Logging" 750
		else
			display_message "Not Logging" 750
		fi
	fi
}

main
