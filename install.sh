#!/usr/bin/env bash
set -euo pipefail
repo="lucasonline0/KindleForge"; arch="$(uname -m)"; [ "$arch" = x86_64 ] || { echo "KindleForge currently ships x64 Linux builds only." >&2; exit 1; }
tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
api="https://api.github.com/repos/$repo/releases/latest"
json="$(curl -fsSL "$api")" || { echo "Could not read the latest release. For a private repository use: gh release download --repo $repo" >&2; exit 1; }
url="$(printf '%s' "$json" | sed -n 's/.*"browser_download_url": "\([^"]*\.pacman\)".*/\1/p' | head -1)"
if command -v pacman >/dev/null; then sudo pacman -Sy --needed --noconfirm calibre poppler; [ -n "$url" ] || { echo "Pacman asset unavailable" >&2; exit 1; }; curl -fsSL "$url" -o "$tmp/kindleforge.pkg.tar.zst"; sumurl="$(printf '%s' "$json" | sed -n 's/.*"browser_download_url": "\([^"]*SHA256SUMS\)".*/\1/p' | head -1)"; curl -fsSL "$sumurl" -o "$tmp/SHA256SUMS"; (cd "$tmp" && sha256sum -c SHA256SUMS --ignore-missing); sudo pacman -U --noconfirm "$tmp/kindleforge.pkg.tar.zst"; else url="$(printf '%s' "$json" | sed -n 's/.*"browser_download_url": "\([^"]*\.AppImage\)".*/\1/p' | head -1)"; [ -n "$url" ] || exit 1; mkdir -p "$HOME/.local/bin"; curl -fsSL "$url" -o "$HOME/.local/bin/kindleforge"; chmod +x "$HOME/.local/bin/kindleforge"; fi
echo "KindleForge installed. Run: kindleforge"
