# .profile
#

# settings for cygnus win32
# export MAKE_MODE=UNIX
# export TERM=cygwin
#LD_LIBRARY_PATH shows where the .dll's are located

#ENV=$HOME/.kshrc            # for subsequent ksh invocations
#export ENV

#export LD_LIBRARY_PATH=/usr/lpp/db2_05_00/lib
#. /db2/sqllib/db2profile
# export PATH=~/lib/script:$PATH
# 
# if [ ! "$DT" ]
# then
#    WHOAMI=`who am i`
#    set $WHOAMI
#    # FULLHOST=`echo $6 | cut -f1 -d"." `
#    FULLHOST=`echo $6 | cut -f1 -d")" `
#    REMOTEHOST=`echo $FULLHOST | cut -f2 -d"(" `
#    DISPLAY=${DISPLAY:-"$REMOTEHOST:0"}
#    export DISPLAY
#    echo "DISPLAY=$DISPLAY"
# 
# #   if [ -s "$MAIL" ]           # This is at Shell startup.  In normal
# #   then echo "$MAILMSG"        # operation, the Shell checks
# #   fi                          # periodically.
# 
#    if [ "$TERM" = "ANSI" ]; then
#         export TERM=vt100
#    fi
# 
#    if [ "$TERM" = "vt100" ]; then
#         echo
#         echo "How manny lines does our TERM use ? (25) \c"
#         read dummy
#         LINES=${dummy:-"25"}
#         echo "How manny columns does our TERM use ? (80) \c"
#         read dummy
#         COLUMNS=${dummy:-"80"}
#         export LINES COLUMNS
#         echo "You will use $LINES lines and $COLUMNS columns on your terminal."
#    fi
# fi                             
# 
# 
# if [ ! "$DT" ]
# then
#    # check the processes
#    ps -f
# fi
# 
# # ALIASES
# alias 'fgrep=fgrep -n'
# alias 'vi=vim'
# 

export HOST=$(hostname)
PWD=$(pwd)
#PS1='$USER@$HOST:$PWD>'
PS1=' *** $USERNAME@$HOSTNAME:$PWD\n% '

export host=$HOST

set -o emacs
export EDITOR="emacs";
