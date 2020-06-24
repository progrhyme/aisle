# sh

if [ -z "${DOTS_ROOT:-}" ]; then
  return 1
fi

# Prevent loading multiple times
if [ -n "${_DOT_SH_LOADED:-}" ]; then
  return
fi
_DOT_SH_LOADED=1

# Load target shell scripts
# Known issue:
# - When require() is called simultaneously, $_dot_require_count is shared
#   among callers. It might result in unexpected behavior.
require() {
  _dot_require_count=0

  if [ -r "${DOTS_ROOT}/$1" ]; then
    _dot_require_count=$((_dot_require_count+1))
    . "${DOTS_ROOT}/$1"
  fi

  if [ -n "${DOTS_ENV:-}" ]; then
    if [ -r "$(_dots_env_dir)/$1" ]; then
      _dot_require_count=$((_dot_require_count+1))
      . "$(_dots_env_dir)/$1"
    fi
  fi

  if [ $_dot_require_count -eq 0 ]; then
    return 1
  fi
}

# Print path of target resource file
passage() {
  if [ -n "$(_dots_env_dir)" ]; then
    if [ -e "$(_dots_env_dir)/$1" ]; then
      echo "$(_dots_env_dir)/$1"
      return
    fi
  fi

  if [ -e "${DOTS_ROOT}/$1" ]; then
    echo "${DOTS_ROOT}/$1"
    return
  fi

  return 1
}

alias route=passage

_dots_env_dir() {
  [ -n "${DOTS_ENV:-}" ] || return
  echo "${DOTS_ROOT}/envs/${DOTS_ENV}"
}
