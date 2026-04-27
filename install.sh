#!/usr/bin/env sh
set -eu

REPO_URL="${TERMUX_THEME_REPO_URL:-https://github.com/dianedef/termux-theme}"
BRANCH="${TERMUX_THEME_BRANCH:-main}"
PREFIX="${PREFIX:-$HOME/.local}"
BIN_DIR="$PREFIX/bin"
THEME_DIR="$HOME/.termux/themes"

log() {
  printf '%s\n' "$*"
}

fail() {
  printf 'install.sh: %s\n' "$*" >&2
  exit 1
}

need_cmd() {
  command -v "$1" >/dev/null 2>&1
}

install_fzf_if_possible() {
  if need_cmd fzf; then
    return
  fi

  if need_cmd pkg; then
    log "Installing fzf with pkg..."
    pkg install -y fzf
    return
  fi

  fail "fzf is required. Install it first, then rerun this installer."
}

copy_from_source() {
  src="$1"
  mkdir -p "$BIN_DIR" "$THEME_DIR"
  cp "$src/bin/termux-theme" "$BIN_DIR/termux-theme"
  chmod 755 "$BIN_DIR/termux-theme"
  cp "$src"/themes/*.properties "$THEME_DIR/"
}

download_source() {
  tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/termux-theme-install.XXXXXX")"
  archive="$tmp_dir/source.tar.gz"
  url="$REPO_URL/archive/refs/heads/$BRANCH.tar.gz"

  if need_cmd curl; then
    curl -fsSL "$url" -o "$archive"
  elif need_cmd wget; then
    wget -qO "$archive" "$url"
  else
    fail "curl or wget is required to download $url"
  fi

  tar -xzf "$archive" -C "$tmp_dir"
  find "$tmp_dir" -mindepth 1 -maxdepth 1 -type d | head -n 1
}

install_fzf_if_possible

script_dir="$(CDPATH= cd -- "$(dirname -- "$0")" 2>/dev/null && pwd || printf '.')"
if [ -f "$script_dir/bin/termux-theme" ] && [ -d "$script_dir/themes" ]; then
  source_dir="$script_dir"
else
  source_dir="$(download_source)"
fi

copy_from_source "$source_dir"

log "Installed termux-theme to $BIN_DIR/termux-theme"
log "Installed themes to $THEME_DIR"
log "Run: termux-theme"
