#!/usr/bin/env zsh
# -*- mode: sh;sh-indentation: 4;indent-tabs-mode: nil;sh-basic-offset: 4; -*-
#
# Copyright (c) 2023 Sebastian Gniazdowski
#

builtin emulate -L zsh
builtin setopt extendedglob kshglob warncreateglobal typesetsilent \
                noshortloops rcquotes noautopushd

# Possibly fix $0 with a new trick – use of a %x prompt expansion
0="${${(M)${0::=${(%):-%x}}:#/*}:-$PWD/$0}"

export XZDIR XZBIN_DIR XZFUNCS XZAES XZLOG
# Restore the variables if needed (i.e. not exported)
: ${XZDIR:=$0:h:h} ${XZBIN_DIR::=$0:h:h/bin} \
       ${XZFUNCS=::$0:h:h/functions} \
       ${XZAES=::$0:h:h/aliases} \
       ${XZLOG:=$(mktemp)}

# Unset helper function on exit
builtin trap 'unset -f xzmsg_subst xzmsg_cmd_helper &>$XZLOG' EXIT

# Mute possible create global warning
typeset -ag match mbegin mend reply
typeset -g MATCH REPLY; integer -g MBEGIN MEND

# Set up aliases (global, suffix and the proper ones)
[[ -f $XZAES/*[^~](#qNY1.,@) ]]&&for REPLY in $XZAES/*[^~](.,@);do
    REPLY="$REPLY:t=$(<$REPLY)"
    alias "${${REPLY#*=}%%:*}" "${(M)REPLY##[^=]##}=${REPLY#*:}"
done

xzclean() {
    # Cleanup
    REPLY= MATCH= MBEGIN= MEND= reply=() match=() mbegin=() mend=()
}

xzclean

# Load any case both files and symlinks (@ and .)
builtin autoload -z regex-replace "$XZFUNCS"/*[^~](N.,@)
 