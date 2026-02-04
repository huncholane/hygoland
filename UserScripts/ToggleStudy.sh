#!/bin/bash

PID_FILE="/tmp/study_music.pid"
AUDIO_FILE=~/Music/study.wav

if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    if kill -0 "$PID" 2>/dev/null; then
        kill "$PID"
        echo "Stopped study music."
        rm "$PID_FILE"
        exit 0
    else
        rm "$PID_FILE"
    fi
fi

# ffplay -nodisp -autoexit -loop 0 "$AUDIO_FILE" >/dev/null 2>&1 &
paplay --device=alsa_output.pci-0000_00_1f.3.analog-stereo "$AUDIO_FILE" &
echo $! >"$PID_FILE"
echo "Started study music."
