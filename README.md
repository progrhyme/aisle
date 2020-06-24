# dot-sh

A few shell scripts to help you organize dotfiles for multiple environments.

# Usage

```sh
DOTSH_ROOT=path/to/dot-sh
DOTS_ROOT=path/to/dotfiles
DOTS_ENV=darwin

# Loads all scripts in this project
. $DOTSH_ROOT/dot.sh

require .profile.extra
```

Then, `$DOTS_ROOT/.profile.extra` and `$DOTS_ROOT/envs/darwin/.profile.extra` are sourced in order.

## Option: install by shelp

You can install **dot-sh** by [progrhyme/shelp](https://github.com/progrhyme/shelp).

```sh
$ shelp install progrhyme/dot-sh
```

Then, you can use `dot.sh` like this way:

```sh
#!/path/to/your-favorite-shell

eval "$(shelp init -)"

DOTS_ROOT=path/to/dotfiles
DOTS_ENV=darwin

include dot-sh dot.sh
```

# License

The MIT License.

Copyright (c) 2020 IKEDA Kiyoshi.
