# sh
#
# Load all scripts in this project

DOTSH_VERSION="0.1.0"

DOTSH_ROOT=${DOTSH_ROOT:-}
if [ -n "$DOTSH_ROOT" ]; then
  . $DOTSH_ROOT/core.sh
  . $DOTSH_ROOT/link.sh
  return
fi

# In the following scripts, these are assumed:
# - `shelp` is installed
# - This repository is installed as a shelp package
if ! command -v include >/dev/null 2>&1; then
  eval "$(shelp init -)"
fi

DOTSH_PACKAGE=${DOTSH_PACKAGE:-dot-sh}
include $DOTSH_PACKAGE core.sh
include $DOTSH_PACKAGE link.sh
