#!/bin/bash
# /* ---- 💫 Region screen-to-GIF capture 💫 ---- */  ##
# Toggle binding: first press selects a region with slurp and starts
# wf-recorder. Second press stops the recording and converts the result
# to GIF via ffmpeg with a generated palette for better quality.
# Output is saved to ~/Pictures/Screencasts. Feedback is rendered via
# hyprctl notify so a notification daemon is not required.

# Variables
outDIR="$HOME/Pictures/Screencasts"
tmpMP4="/tmp/screengif-record.mp4"
tmpPAL="/tmp/screengif-palette.png"
fps=12
maxWidth=720

mkdir -p "$outDIR"

notify() {
	# args: time_ms message color(optional)
	local ms="$1"; shift
	local color="${2:-rgb(f6004c)}"
	hyprctl notify -1 "$ms" "$color" "$1" >/dev/null
}

# Stop running recorder (toggle off)
if pgrep -x wf-recorder >/dev/null; then
	notify 1500 "Stopping recording…"
	pkill -SIGINT -x wf-recorder

	while pgrep -x wf-recorder >/dev/null; do sleep 0.1; done

	if [ ! -s "$tmpMP4" ]; then
		notify 3000 "No recording captured."
		exit 1
	fi

	ts="$(date +%Y%m%d-%H%M%S)"
	outGIF="$outDIR/screengif-$ts.gif"

	notify 2000 "Encoding GIF…"

	ffmpeg -y -v error -i "$tmpMP4" \
		-vf "fps=${fps},scale='min(${maxWidth},iw)':-2:flags=lanczos,palettegen=stats_mode=diff" \
		"$tmpPAL"

	ffmpeg -y -v error -i "$tmpMP4" -i "$tmpPAL" -filter_complex \
		"fps=${fps},scale='min(${maxWidth},iw)':-2:flags=lanczos[x];[x][1:v]paletteuse=dither=bayer:bayer_scale=5" \
		"$outGIF"

	rm -f "$tmpMP4" "$tmpPAL"

	sizeKB=$(( $(stat -c %s "$outGIF") / 1024 ))
	echo -n "$outGIF" | wl-copy
	notify 5000 "Saved ${outGIF##*/} (${sizeKB} KB) — path on clipboard"
	exit 0
fi

# Start a new recording (toggle on)
region="$(slurp)" || { notify 2000 "Region selection cancelled."; exit 1; }

rm -f "$tmpMP4"
notify 3000 "Recording — press Mod+Shift+G to stop"

wf-recorder -g "$region" -f "$tmpMP4"
