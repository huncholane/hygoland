#!/usr/bin/env python3
"""Record audio from default input until SIGINT, save as 16kHz mono WAV."""

import signal
import struct
import sys
import wave

import numpy as np
import sounddevice as sd

SAMPLE_RATE = 16000
CHANNELS = 1
DTYPE = "int16"

if len(sys.argv) < 2:
    print("usage: whisper-record.py <out.wav>", file=sys.stderr)
    sys.exit(1)

out_path = sys.argv[1]
chunks: list[np.ndarray] = []
stop = False


def on_signal(_sig, _frame):
    global stop
    stop = True


signal.signal(signal.SIGINT, on_signal)
signal.signal(signal.SIGTERM, on_signal)

with sd.InputStream(
    samplerate=SAMPLE_RATE, channels=CHANNELS, dtype=DTYPE
) as stream:
    while not stop:
        chunk, _ = stream.read(1600)  # 100ms blocks
        chunks.append(chunk.copy())

if chunks:
    audio = np.concatenate(chunks).flatten().astype(np.int16)
    with wave.open(out_path, "wb") as w:
        w.setnchannels(CHANNELS)
        w.setsampwidth(2)
        w.setframerate(SAMPLE_RATE)
        w.writeframes(audio.tobytes())
