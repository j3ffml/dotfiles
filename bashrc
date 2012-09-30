# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# 256 colors
export XTERM=xterm-256color

# dircolors
if [ -f ~/.dircolors ]; then
    eval `dircolors .dircolors`
fi

# set a fancy prompt
PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"

# enable color support of ls and also add handy aliases

alias ls='ls --color'
alias ll='ls -l'
alias la='ls -A'
alias df='df -h'
alias du='du -h'

# load aliases
#TODO
if [ -e "$HOME/.bash_aliases" ]; then
    . "$HOME/.bash_aliases"
fi

# load machine-specific settings
if [ -e "$HOME/.bash_local" ]; then
    . "$HOME/.bash_local"
fi


