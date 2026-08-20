#!/usr/bin/env bash
set -euo pipefail
repo="lucasonline0/kindleforge"; arch="$(uname -m)"; [ "$arch" = x86_64 ] || { echo "KindleForge currently ships x64 Linux builds only." >&2; exit 1; }
tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
base="https://github.com/$repo/releases/latest/download"
if command -v pacman >/dev/null; then sudo pacman -Sy --needed --noconfirm calibre poppler; curl -fsSL "$base/kindleforge-1.0.0-x64.pacman" -o "$tmp/kindleforge-1.0.0-x64.pacman"; curl -fsSL "$base/SHA256SUMS" -o "$tmp/SHA256SUMS"; (cd "$tmp" && grep 'kindl.*\.pacman$' SHA256SUMS | sha256sum -c -); sudo pacman -U --noconfirm "$tmp/kindleforge-1.0.0-x64.pacman"; else mkdir -p "$HOME/.local/bin"; curl -fsSL "$base/KindleForge-1.0.0-x64.AppImage" -o "$HOME/.local/bin/kindleforge"; chmod +x "$HOME/.local/bin/kindleforge"; fi
echo "KindleForge installed. Run: kindleforge"
