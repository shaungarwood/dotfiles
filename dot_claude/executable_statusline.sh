#!/usr/bin/env bash
# Claude Code status line.
#
#   work-thing · Opus 5 · ~/repos/ccapi/main  main  23%

set -u

json=$(cat)

# One field per line — bash treats tab as IFS whitespace, so a tab-separated
# read would collapse empty fields and shift the values left.
name="" model="" dir="" ctx=""
{
    read -r name || true
    read -r model || true
    read -r dir || true
    read -r ctx || true
} <<EOF
$(printf '%s' "$json" | jq -r '
  .session_name // "",
  .model.display_name // "",
  .workspace.current_dir // .cwd // "",
  (if .context_window.used_percentage == null then ""
   else (.context_window.used_percentage | floor | tostring) end)')
EOF

dim=$'\033[38;2;88;110;117m'  # solarized base01
blue=$'\033[38;2;38;139;210m' # solarized blue
green=$'\033[38;2;133;153;0m' # solarized green
yellow=$'\033[38;2;181;137;0m'
red=$'\033[38;2;220;50;47m'
off=$'\033[0m'

branch=""
if [ -n "$dir" ] && [ -d "$dir" ]; then
    branch=$(git -C "$dir" symbolic-ref --quiet --short HEAD 2>/dev/null) || branch=""
fi

pretty_dir=${dir/#$HOME/\~}

ctx_color=$dim
if [ -n "$ctx" ]; then
    if [ "$ctx" -ge 90 ]; then
        ctx_color=$red
    elif [ "$ctx" -ge 70 ]; then
        ctx_color=$yellow
    fi
fi

out=""
add() { out="${out:+$out ${dim}·${off} }$1"; }

[ -n "$name" ] && add "$blue$name$off"
[ -n "$model" ] && add "$dim$model$off"
[ -n "$pretty_dir" ] && add "$dim$pretty_dir$off"
[ -n "$branch" ] && add "$green$branch$off"
[ -n "$ctx" ] && add "$ctx_color$ctx%$off"

printf '%s' "$out"
exit 0
