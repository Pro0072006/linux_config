#!/bin/bash

FONT_DIR="/usr/share/fonts/jetbrains-mono"

sudo mkdir -p "$FONT_DIR"

sudo unzip -o "JetBrainsMono-2.304.zip" -d "$FONT_DIR"

sudo fc-cache -f -v
fc-cache -f -v

echo "Jetbrains mono installed"
