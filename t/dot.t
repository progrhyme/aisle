# sh

t_diag "Tests for dot.sh"

DOTSH_ROOT=.

. ./dot.sh

t_eq $_DOT_SH_LOADED 1 "core.sh is loaded"
t_present "$DOT_LINK_CMD" "link.sh is loaded"
