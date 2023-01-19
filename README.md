# xzmsg

A flexible message printing tool. With `xzmsg`:
- no quoting is needed, `xzmsg {err}Error: {%}problem occurred {txt}(info)`,
will work,
- a standard file location header `[xzmsg:10][XZ]: …message` on `xzmsg -h …`,
- themes – customize the color palette used.

`xzmsg` can be used as function on Zsh (via `autoload` builtin) or as a script,
and also on Bash (as script, via `#!/usr/bin/env zsh`).

## Customization

You can export following variables:
- `APPNICK`, for standard message preamble tag: [app][file:line], default `XZ`,
- `XZCONF`, default `${XDG_CONFIG_HOME:-$HOME/.config}/xzmsg`,
- `XZCACHE`, default `${XDG_CACHE_HOME:-$HOME/.cache}/xzmsg`,
- `XZINI`, default `$XZCACHE/${(L)APPZNICK}.xzc}`,
- `XZLOG`, default `$XZCACHE/${(L)APPZNICK}.xzl}`,
- `XZTHEME`, default `$XZDIR/themes/default.xzt}`.

## Screenshots

![screenshot](https://github.com/psprint/xzmsg/blob/master/img/screenshot.png)

Blue theme:

![screenshotblue](https://github.com/psprint/xzmsg/blob/master/img/screenshotblue.png)
