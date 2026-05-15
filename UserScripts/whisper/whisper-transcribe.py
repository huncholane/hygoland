#!/usr/bin/env python3
"""Transcribe a WAV with faster-whisper. Print plain text to stdout."""

import glob
import os
import site
import sys


def _add_cuda_libs():
    """Locate pip-installed cuBLAS / cuDNN .so dirs and prepend to LD_LIBRARY_PATH."""
    candidates = []
    for base in site.getsitepackages() + [site.getusersitepackages()]:
        for sub in ("nvidia/cublas/lib", "nvidia/cudnn/lib"):
            path = os.path.join(base, sub)
            if os.path.isdir(path):
                candidates.append(path)
    # Also check virtualenv site-packages explicitly
    venv = os.environ.get("VIRTUAL_ENV") or os.path.dirname(
        os.path.dirname(sys.executable)
    )
    for sub in ("nvidia/cublas/lib", "nvidia/cudnn/lib"):
        for hit in glob.glob(
            os.path.join(venv, "lib", "python*", "site-packages", sub)
        ):
            candidates.append(hit)
    candidates = list(dict.fromkeys(candidates))  # dedupe
    if candidates:
        os.environ["LD_LIBRARY_PATH"] = ":".join(
            candidates + [os.environ.get("LD_LIBRARY_PATH", "")]
        ).rstrip(":")


_add_cuda_libs()

from faster_whisper import WhisperModel  # noqa: E402

if len(sys.argv) < 2:
    print("usage: whisper-transcribe.py <in.wav> [model] [device]", file=sys.stderr)
    sys.exit(1)

wav = sys.argv[1]
model_name = sys.argv[2] if len(sys.argv) > 2 else "small.en"
device = sys.argv[3] if len(sys.argv) > 3 else "cuda"

compute_type = "float16" if device == "cuda" else "int8"

try:
    model = WhisperModel(model_name, device=device, compute_type=compute_type)
except Exception as e:
    print(f"[whisper-transcribe] CUDA init failed: {e}; falling back to CPU", file=sys.stderr)
    model = WhisperModel(model_name, device="cpu", compute_type="int8")

segments, _info = model.transcribe(wav, language="en", beam_size=5, vad_filter=True)
text = " ".join(seg.text.strip() for seg in segments).strip()
print(text)
