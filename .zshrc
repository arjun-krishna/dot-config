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
zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 14
DISABLE_MAGIC_FUNCTIONS="false"
DISABLE_LS_COLORS="false"
DISABLE_AUTO_TITLE="false"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
DISABLE_UNTRACKED_FILES_DIRTY="true"
plugins=(git vi-mode zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
# vi-mode
bindkey -v
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
bindkey -M viins 'jk' vi-cmd-mode
MODE_INDICATOR="%F{white}+%f"
INSERT_MODE_INDICATOR="%F{yellow}+%f"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

TERM=xterm-256color
bindkey '^ ' autosuggest-accept

# rust setup
if [ -d "$HOME/.cargo" ]; then
	export PATH="$PATH:$HOME/.cargo/bin"
fi

# Node Version Manager
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# add custom bins/programs in .local/bin to sh path
export PATH="$HOME/.local/bin:$PATH"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='vim'
else
	export EDITOR='nvim'
fi

if [[ $(uname) == "Darwin" ]]; then
    source "$HOME/.zshrc.custom/osx.zsh"
else
	source "$HOME/.zshrc.custom/linux.zsh"
fi

# alias
alias pyd=python -m pdb -c continue