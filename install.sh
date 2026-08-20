#!/usr/bin/env bash
set -euo pipefail
repo="lucasonline0/kindleforge"; arch="$(uname -m)"; [ "$arch" = x86_64 ] || { echo "KindleForge currently ships x64 Linux builds only." >&2; exit 1; }
tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
base="https://github.com/$repo/releases/latest/download"
if command -v pacman >/dev/null; then sudo pacman -Sy --needed --noconfirm calibre poppler; if pacman -Q kindleforge >/dev/null 2>&1; then sudo pacman -Rdd --noconfirm kindleforge; fi; fi; curl -fsSL "$base/KindleForge-1.0.2-x64.AppImage" -o "$tmp/KindleForge-1.0.2-x64.AppImage"; curl -fsSL "$base/SHA256SUMS" -o "$tmp/SHA256SUMS"; (cd "$tmp" && grep 'KindleForge.*\.AppImage$' SHA256SUMS | sha256sum -c -); sudo install -Dm755 "$tmp/KindleForge-1.0.2-x64.AppImage" /usr/bin/kindleforge
echo "KindleForge installed. Run: kindleforge"
