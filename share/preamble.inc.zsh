#!/usr/bin/env zsh
# -*- mode: sh;sh-indentation: 4;indent-tabs-mode: nil;sh-basic-offset: 4; -*-
#
# Copyright (c) 2023 Sebastian Gniazdowski
#

builtin emulate -L zsh
builtin setopt extendedglob warncreateglobal typesetsilent \
                noshortloops rcquotes noautopushd

# Possibly fix $0 with a new trick – use of a %x prompt expansion
0=${${(%):-%x}%/*~*/xzmsg.plugin.zsh}
0=${${(M)0:#/*}:-$PWD/$0}

: ${XZDIR:=$0:h} ${XZBIN_DIR::=${0:h}/bin} \
       ${XZFUNC_DIR=::${0:h}/functions} \
       ${XZAES_DIR=::${0:h}/aliases}

# Unset helper function on exit
builtin trap 'unset -f xzmsg_subst xzmsg_cmd_helper' EXIT

# Mute possible create global warning
local -a match mbegin mend reply
local MATCH REPLY; integer MBEGIN MEND

# Set up aliases (global, suffix and the proper ones)
for REPLY in $XZAES_DIR/*[a-zA-Z];do
    REPLY="$REPLY:t=$(<$REPLY)"
    alias "${${REPLY#*=}%%:*}" "${(M)REPLY##[^=]##}=${REPLY#*:}"
done
