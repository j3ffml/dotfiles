# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# ZSH_THEME="agnoster"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git autojump python vi-mode)

source $ZSH/oh-my-zsh.sh

# PATH customization
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/go/bin
export GOPATH=$HOME/go
export GOPATH=$GOPATH
export PATH=$PATH:$GOPATH:$GOPATH/bin

# command aliases
if [[ `uname -a` == *"Darwin"* ]]; then
  export CLICOLOR=1
  export LSCOLORS=exgxfxdxcxegedabagaced
  alias ls='ls -G'
else
  alias ls='ls --color'
  alias ack='ack-grep'
fi

# options
setopt correctall
setopt autocd
setopt extendedglob
unsetopt beep

autoload -Uz compinit
compinit

source "$HOME/.zsh.prompt"

# Incremental backwards search
bindkey -M viins \\C-R history-incremental-search-backward

# The following fixes home, end, del keys, because zsh is sometimes dumb
# http://zshwiki.org/home/zle/bindkeys
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      history-beginning-search-backward
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    history-beginning-search-forward
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
function zle-line-init () {
    echoti smkx
}
function zle-line-finish () {
    echoti rmkx
}
zle -N zle-line-init
zle -N zle-line-finish

bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward

# load additional local settings
if [[ -e "$HOME/.zsh_local" ]]; then
    . "$HOME/.zsh_local"
fi

