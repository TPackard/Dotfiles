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

export PATH="$PATH:$HOME/bin:$HOME/.cargo/bin"
export LD_LIBRARY_PATH="/usr/local/lib"

# Use vi keybindings for zsh
bindkey -v

# Load colors
autoload -U colors && colors

# Set default editor to nvim
export VISUAL="nvim"
export EDITOR="nvim"

# Alias `suvim` to run vim under superuser while maintaining the same preferences
alias suvim='sudo -E vim'

# Alias vi to vim
alias vi='nvim'
alias suvi='sudo -E nvim'

# Use colored commands
alias ls='ls --color=auto'
alias grep='grep --color=auto'
eval $(dircolors ~/.dircolors)

# Fix colors for terminals that only support setting 16 colors
# FIXME: make portable
BASE16_SHELL="$HOME/projects/base16/output/shell/scripts/base16-tylermode_light.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# Aliases
alias ssh='TERM=xterm-256color ssh'
alias brightness='sudo tee /sys/class/backlight/intel_backlight/brightness <<<'

# Include custom prompt
source ~/.zsh_prompt

# Source directory for wmutils scripts
export WM_SCRIPTS=/home/tyler/bin/wmutils

# IBus
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

# Java
export JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64

# NVM
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# CS140E
export CS140E_2021_PATH=/home/a3a/classes/e041sc/cs140e-21spr
