# dot.sh

A tiny shell script to help you organize dotfiles for multiple environments.

# Usage

```sh
DOTS_ROOT=path/to/dotfiles
DOTS_ENV=darwin

. dot.sh
require .profile.extra
```

Then, `$DOTS_ROOT/.profile.extra` and `$DOTS_ROOT/envs/darwin/.profile.extra` are
sourced in order.

# License

The MIT License.

Copyright (c) 2020 IKEDA Kiyoshi.
