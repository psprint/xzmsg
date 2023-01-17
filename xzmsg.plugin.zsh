#!/usr/bin/env zsh
# -*- mode: sh;sh-indentation: 4;indent-tabs-mode: nil;sh-basic-offset: 4; -*-
#
# Copyright (c) 2023 Sebastian Gniazdowski
#

# Possibly fix $0 with a new trick – use of a %x prompt expansion
0=${(%):-%x}
0=${${(M)0:#/*}:-$PWD/$0}

# Then ${0:h} to get plugin's directory
# Self-manage $fpath if loaded not with plugin manager
if [[ ${zsh_loaded_plugins[-1]} != */xzmsg && -z ${fpath[(r)${0:h}/?*]} ]];then
    fpath+=( "${0:h}/functions" )
fi

# Standard hash for plugins, to not pollute the namespace
typeset -gA Plugins
Plugins[XZDIR]="${0:h}"
export XZDIR="${0:h}" \
       XZBIN_DIR="${0:h}"/bin \
       XZFUNC_DIR="${0:h}"/functions \
       XZAES_DIR="${0:h}"/aliases

# Set up environment
: ${APPNICK:=XZ} # Set for standard message preamble tag: [app][file:line]
: ${XZCONF:=${XDG_CONFIG_HOME:-$HOME/.config}/xzmsg}
: ${XZCACHE:=${XDG_CACHE_HOME:-$HOME/.cache}/xzmsg}
: ${XZINI:=$XZCACHE/${(L)APPZNICK}.xzc}
: ${XZLOG:=$XZCACHE/${(L)APPZNICK}.xzl}
: ${XZTHEME:=$XZDIR/themes/default.xzt}

command mkdir -p $XZCONF $XZCACHE
export APPNICK XZCONF XZCACHE XZLOG XZTHEME

# Safe variables
typeset -g REPLY reply=()

# Set up aliases (global, suffix and the proper ones)
for REPLY in $XZAES_DIR/*[a-zA-Z];do
    REPLY="$REPLY:t=$(<$REPLY)"
    alias "${${REPLY#*=}%%:*}" "${(M)REPLY##[^=]##}=${REPLY#*:}"
done

# Load any case (#i) and both files and symlinks (@ and .)
builtin autoload -z "$XZFUNC_DIR"/*[0-9A-Za-z](N.,@)

# vim:ft=zsh:tw=80:sw=4:sts=4:et:foldmarker=[[[,]]]
