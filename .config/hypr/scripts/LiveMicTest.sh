#!/bin/bash
if systemctl --user is-active --quiet live-mic; then
	systemctl --user stop live-mic
else
	systemctl --user start live-mic
fi
