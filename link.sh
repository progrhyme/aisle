# sh
#
# Assume followings:
# - dot.sh is loaded
# - `links` command is found in $PATH

# for Zsh compatibility
if command -v emulate >/dev/null 2>&1; then
  emulate -R sh
fi

DOT_LINK_FORCE=${DOT_LINK_FORCE:-}
DOT_LINK_SILENT=${DOT_LINK_SILENT:-}
DOT_LINK_VERBOSE=1

if [ -n "$DOT_LINK_SILENT" ]; then
  DOT_LINK_VERBOSE=
fi

if ! command -v links >/dev/null 2>&1; then
  echo "Error! links is not installed!" >&2
  return 1
fi

if [ -n "$DOT_LINK_VERBOSE" ]; then
  DOT_LINK_CMD="links --verbose"
else
  DOT_LINK_CMD="links"
fi
if [ -n "$DOT_LINK_FORCE" ]; then
  DOT_LINK_CMD="${DOT_LINK_CMD} --force"
fi

# Create symlink to $1 at $HOME/$1
# Use route() by dot.sh
link_home() {
  _src="$(route "$1" || true)"
  if [ -z "$_src" ]; then
    echo "[error] $1 doesn't exist!" >&2
    return 1
  fi
  _link="${HOME}/$1"
  _dir="${1%/*}"
  if [ "$_dir" != "$1" ]; then
    _dot_mkdir_p "$HOME/${_dir}"
  fi
  $DOT_LINK_CMD "$_src" "$_link"
  unset _src _link _dir
}

# Create symlink to $1(a) at $2(b)
# Use route() by dot.sh
link_b2a() {
  _src="$(route "$1" || true)"
  if [ -z "$_src" ]; then
    echo "[error] $1 doesn't exist!" >&2
    return 1
  fi
  _link="$2"
  _dir="${2%/*}"
  _dot_mkdir_p "$_dir"
  $DOT_LINK_CMD "$_src" "$_link"
  unset _src _link _dir
}

# Run `mkdir -p` if needed
_dot_mkdir_p() {
  if [ -d "$1" ]; then
    if [ -n "$DOT_LINK_VERBOSE" ]; then
      echo "[ok] Directory $1 already exists"
    fi
  elif [ -e "$1" ]; then
    echo "[error] Can't create directory! File exists at $1" >&2
    return 1
  else
    mkdir -p "$1"
    if [ -n "$DOT_LINK_VERBOSE" ]; then
      echo "[ok] mkdir $1"
    fi
  fi
}
