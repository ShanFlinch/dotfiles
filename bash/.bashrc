#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
#    __               __             
#   / /_  ____ ______/ /_  __________
#  / __ \/ __ `/ ___/ __ \/ ___/ ___/
# / /_/ / /_/ (__  ) / / / /  / /__  
#/_.___/\__,_/____/_/ /_/_/   \___/  
#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

[[ $- != *i* ]] && return                  #Exit if not a human

stty -ixon                                 #Disable ctrl-s and ctrl-q
shopt -s autocd                            #Allow cd just by typing directory name

alias mkdir='mkdir -pv'                    #Makes directories and tells you what it did
alias cp='cp -iv'                          #Ask before overwriting and show what is copied
alias mv='mv -iv'                          #Ask before overwriting
alias df='df -h'                           #Show disk space in GB/MB instead of bytes
alias free='free -m'                       #Show memory usage in MB

alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lh'                          #Long list
alias lr='ll -tr'                          #Long list sort by newest at bottom
alias grep='grep --color=auto'

alias c='clear'

HISTCONTROL=ignoreboth                     #Dont put duplicate line or starting with space
shopt -s histappend                        #Append to history file not overwrite
HISTSIZE=10000
HISTFILESIZE=20000
bind '"\e[A": history-search-backward'     #Use up/down to search through history
bind '"\e[B": history-search-forward'

export YAZI_CONFIG_HOME="$HOME/.config/yazi"

eval "$(starship init bash)"               #Starship duh
. "$HOME/.cargo/env"
