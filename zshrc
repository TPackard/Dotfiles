# Use http://zsh.sourceforge.net/Doc/Release/zsh_toc.html for reference

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory beep extendedglob
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/Tyler/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_HOME

export PATH="$PATH:$HOME/bin:$HOME/.gem/ruby/2.3.0/bin"

# Use vi keybindings
bindkey -v

# Load colors
autoload -U colors && colors

# Set default editor to vim
export VISUAL="vim"
export EDITOR="vim"

# Use colored ls
alias ls='ls --color=auto'
eval $(dircolors ~/.dircolors)

# Aliases
alias ssh='TERM=xterm-256color ssh'

# Include custom prompt
source ~/.zsh_prompt

# IBus
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
