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
Plugins[XZMSG_DIR]="${0:h}"
export XZMSG_DIR="${0:h}" \
       XZFUNC_DIR="${0:h}"/functions \
       XZAES_DIR="${0:h}"/aliases

# Set up environment
: ${APPNICK:=XZ} # Set for standard message preamble tag: [app][file:line]
: ${XZCONF:=${XDG_CONFIG_HOME:-$HOME/.config}/xzmsg}
: ${XZCACHE:=${XDG_CACHE_HOME:-$HOME/.cache}/xzmsg}
: ${XZLOG:=$XZCACHE/${(L)APPZNICK}.log}
: ${XZTHEME:=$XZMSG_DIR/themes/default.cfg}
command mkdir -p $XZCONF $XZCACHE
export APPNICK XZCONF XZCACHE XZLOG XZTHEME

# Safe variables
typeset -g REPLY reply=()

# Set up aliases (global and the proper ones)
for REPLY in $XZAES_DIR/*[a-zA-Z];do
    REPLY="$REPLY:t=$(<$REPLY)"
    alias "${${REPLY#*=}%%:*}" "${(M)REPLY##[^=]##}=${REPLY#*:}"
done

() {
    builtin emulate -L zsh -o extendedglob
    # Load any case (#i) and both files and symlinks (@ and .)
    autoload -z $XZFUNC_DIR/(#i)*[a-z](N@:t) $XZFUNC_DIR/(#i)*[a-z](N.:t)
}

# vim:ft=zsh:tw=80:sw=4:sts=4:et:foldmarker=[[[,]]]
