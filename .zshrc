# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
DEFAULT_USER="akrishna"

zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 14

DISABLE_MAGIC_FUNCTIONS="false"
DISABLE_LS_COLORS="false"
DISABLE_AUTO_TITLE="false"

ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# COMPLETION_WAITING_DOTS="true"

DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

plugins=(git vi-mode zsh-syntax-highlighting zsh-autosuggestions poetry)

source $ZSH/oh-my-zsh.sh

# User configuration

# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias s="kitty +kitten ssh"
alias icat="kitty +kitten icat"

bindkey '^ ' autosuggest-accept

# ROS setup
if [ -f /opt/ros/noetic/setup.zsh ]; then
	source /opt/ros/noetic/setup.zsh
	alias cbuild="catkin build --profile release"
	if [ -f $HOME/catkin_ws/devel_release/setup.zsh ]; then
		source $HOME/catkin_ws/devel_release/setup.zsh
	elif [ -f $HOME/catkin_ws/devel/setup.zsh ]; then
		source $HOME/catkin_ws/devel/setup.zsh
	fi
fi

# vi-mode
bindkey -v
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
bindkey -M viins 'jk' vi-cmd-mode
MODE_INDICATOR="%F{white}+%f"
INSERT_MODE_INDICATOR="%F{yellow}+%f"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# rust setup
if [ -d "$HOME/.cargo" ]; then
	export PATH="$PATH:$HOME/.cargo/bin"
fi

# Node Version Manager
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='vim'
else
	export EDITOR='nvim'
fi

# PyEnv setup
if [ -d "$HOME/.pyenv" ]; then
	export PYENV_ROOT="$HOME/.pyenv"
	command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init -)"
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/akrishna/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/akrishna/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/akrishna/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/akrishna/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/Users/akrishna/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/Users/akrishna/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<
