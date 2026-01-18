DEFAULT_USER="akrishna"

# >>> homebrew initialize >>>
# !! hack as .zprofile doesn't load with alacritty
if [ -v $HOMEBREW_PREFIX ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export PATH="$PATH:/Library/TeX/texbin"

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
#
export DBUS_SESSION_BUS_ADDRESS='unix:path='$DBUS_LAUNCHD_SESSION_BUS_SOCKET
