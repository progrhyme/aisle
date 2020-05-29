# sh

if [ -z "${DOTS_ROOT:-}" ]; then
  return 1
fi

# Prevent loading multiple times
if [ -n "${_DOT_SH_LOADED:-}" ]; then
  return
fi
_DOT_SH_LOADED=1

if [ -z "${DOTS_ENV_DIR:-}" -a -n "${DOTS_ENV:-}" ]; then
  DOTS_ENV_DIR="${DOTS_ROOT}/envs/${DOTS_ENV}"
fi

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

  if [ -n "${DOTS_ENV_DIR:-}" ]; then
    if [ -r "${DOTS_ENV_DIR}/$1" ]; then
      _dot_require_count=$((_dot_require_count+1))
      . "${DOTS_ENV_DIR}/$1"
    fi
  fi

  if [ $_dot_require_count -eq 0 ]; then
    return 1
  fi
}

# Print path of target resource file
route() {
  if [ -n "${DOTS_ENV_DIR:-}" ]; then
    if [ -e "${DOTS_ENV_DIR}/$1" ]; then
      echo "${DOTS_ENV_DIR}/$1"
      return
    fi
  fi

  if [ -e "${DOTS_ROOT}/$1" ]; then
    echo "${DOTS_ROOT}/$1"
    return
  fi

  return 1
}
