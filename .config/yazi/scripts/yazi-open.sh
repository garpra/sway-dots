#!/bin/bash

TARGET="$1"

# Jika file, buka menggunakan nvim
if [ -f "$TARGET" ]; then
  exec nvim "$TARGET"
fi

# Jika directory
if [ -d "$TARGET" ]; then
  # Cek apakah folder kosong
  if [ -z "$(ls -A "$TARGET" 2>/dev/null)" ]; then
    # Folder kosong → kasih sinyal ke Yazi untuk lanjut navigasi
    exit 1
  else
    # Folder ada isi → buka foot dengan path folder
    exec foot --working-directory "$TARGET"
  fi
fi
