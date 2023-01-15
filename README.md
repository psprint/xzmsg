# xzmsg

A flexible message printing tool. With `xzmsg`:
- no quoting is needed, `xzmsg {err}Error: {%}problem occurred {txt}(info)`,
will work,
- a standard file location header `[xzmsg:10][XZ]: …message` on `xzmsg -h …`,
- themes – customize the color palette used.

`xzmsg` can be used as function on Zsh (via `autoload` builtin) or as a script
or also on Bash as script (via `#!/usr/bin/env zsh`).

## Screenshots

![screenshot](https://github.com/psprint/xzmsg/blob/master/img/screenshot.png)
