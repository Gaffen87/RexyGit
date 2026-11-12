#!/bin/sh
# Installs the lazygit toggle into Rex's config directory and reloads Rex.
set -eu

plugin_dir=$(cd -- "$(dirname -- "$0")" && pwd)
init_file=${REX_CONFIG:-${XDG_CONFIG_HOME:-$HOME/.config}/rex/init.lua}
config_dir=$(dirname -- "$init_file")
settings_file=$config_dir/lazygit.lua
toggle_file=$config_dir/lazygit_toggle.lua
require_line='require("lazygit")'

lazygit_bin=${LAZYGIT_BIN:-$(command -v lazygit || true)}
if [ -z "$lazygit_bin" ]; then
  echo "lazygit is not on PATH. Install it (brew install lazygit) or set LAZYGIT_BIN." >&2
  exit 1
fi
lua_quoted_bin=$(printf '%s' "$lazygit_bin" | sed 's/\\/\\\\/g; s/"/\\"/g')

mkdir -p "$config_dir"

{
  echo "-- install.sh of RexyGit writes this file. Do not edit it. Your settings are in lazygit.lua."
  echo "local LAZYGIT_BIN = \"$lua_quoted_bin\""
  echo
  cat "$plugin_dir/lua/lazygit_toggle.lua"
} > "$toggle_file"
echo "wrote $toggle_file"

if [ -e "$settings_file" ]; then
  echo "kept your settings in $settings_file"
else
  cp "$plugin_dir/lua/lazygit.lua" "$settings_file"
  echo "wrote $settings_file with your settings"
fi

if ! grep -qF "$require_line" "$init_file" 2>/dev/null; then
  if [ -s "$init_file" ] && [ -n "$(tail -c 1 "$init_file")" ]; then
    echo >> "$init_file"
  fi
  echo "$require_line" >> "$init_file"
  echo "added $require_line to $init_file"
fi

if rex config reload >/dev/null 2>&1; then
  echo "reloaded Rex's config"
else
  echo "reload Rex's config yourself: rex config reload" >&2
fi
echo "press cmd+l, or run \"Toggle lazygit\" from the command palette"
