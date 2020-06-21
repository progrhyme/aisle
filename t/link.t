# sh

t_diag "Tests for link.sh"

test_symlink() {
  _sym=$1
  _orig=$2
  t_symlink $_sym
  t_is "$(readlink $_sym)" "$_orig" "$_sym -> $_orig"
}

PATH="$(pwd)/bin:$PATH"

mkdir -p tmp/.dot-sh

DOTS_ROOT=$(pwd)
. core.sh
. link.sh
t_eq $? 0 "link.sh is successfully loaded"

link_home tmp/.dot-sh
test_symlink "$HOME/tmp/.dot-sh" "$(pwd)/tmp/.dot-sh"

link_b2a link.sh tmp/link.sh
test_symlink tmp/link.sh "$(pwd)/link.sh"

rm -rf tmp
rm -rf $HOME/tmp/.dot-sh
