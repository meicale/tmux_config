#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
save_complete_history_full_filename="/tmp/save_complete_history_latest.log"
# https://github.com/tmux-plugins/tmux-logging/blob/master/scripts/shared.sh
remove_empty_lines_from_end_of_file() {
	local file=$1
	local temp=$(cat $file)
	printf '%s\n' "$temp" >"$file"
}
# https://github.com/tmux-plugins/tmux-logging/blob/master/scripts/save_complete_history.sh
main() {
	local file="${save_complete_history_full_filename}"
	local history_limit="$(tmux display-message -p -F "#{history_limit}")"
	tmux capture-pane -J -S "-${history_limit}" -p >"${file}"
	remove_empty_lines_from_end_of_file "${file}"
	# use the editor that can copy to clip board
	NVIM_APPNAME=n nvim "${save_complete_history_full_filename}"
	# rm "${save_complete_history_full_filename}"
}
main
