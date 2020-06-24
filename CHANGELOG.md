## 0.2.0 (2020-06-25)

Features: ([#1](https://github.com/progrhyme/dot-sh/pull/1))

- Add `bin/links` as a copy of [progrhyme/bash-links](https://github.com/progrhyme/bash-links), which is a wrapper of ln(1) command
- Add `link.sh` to provide functions to create symlinks of dotfiles

Change: ([#1](https://github.com/progrhyme/dot-sh/pull/1))


- Rename `dot.sh` -> `core.sh`
- (dot.sh) Integrate `core.sh` & `link.sh`. Load both scripts. One must provide `DOTSH_ROOT` variable unless you use [progrhyme/shelp](https://github.com/progrhyme/shelp)
- (core.sh) Rename function `route()` -> `passage()` because `route` is the name of the common network command
  - `route` function is keeped as `alias` of `passage()`. It would help in some shells. But keep in mind the alias will be removed in the future

## 0.1.0 (2020-06-25)

Initial release.
