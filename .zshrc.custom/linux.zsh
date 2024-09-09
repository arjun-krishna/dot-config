setxkbmap -option ctrl:nocaps

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

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/$USER/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/$USER/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/$USER/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/$USER/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/$USER/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/home/$USER/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<
#
export DISPLAY=:1
