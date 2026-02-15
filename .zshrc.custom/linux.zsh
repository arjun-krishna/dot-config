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
move_job() {
    if (( $# < 2 || $# > 3 )); then
        echo "Usage: move_job <jobid> <queue> <?timeLimit>"
        return 1
    fi

    local jobid=$1
    local queue=$2
    local timeLimit="${3:-0}"
    local valid_queues=(l m h)

    # ZSH-native way to check if an element is in an array
    if [[ ${valid_queues[(I)$queue]} -eq 0 ]]; then
        echo "invalid queue target: $queue. valid options are: ${valid_queues[*]}"
        return 1
    fi

    local defaultTimeLimit
    case $queue in
        l|h) defaultTimeLimit="24:00:00" ;;
        m)   defaultTimeLimit="12:00:00" ;;
        *)
            echo "unexpected error."
            return 1
            ;;
    esac

    [[ "$timeLimit" == "0" ]] && timeLimit=$defaultTimeLimit

    if [[ "$queue" == "l" ]]; then
        scontrol update jobid=$jobid partition=batch qos=normal timeLimit=$timeLimit
    elif [[ "$queue" == "h" ]]; then
        scontrol update jobid=$jobid partition=dineshj-compute qos=dj-high timeLimit=$timeLimit
    else
        scontrol update jobid=$jobid partition=dineshj-compute qos=dj-med timeLimit=$timeLimit
    fi
}

move_job_re() {
    if (( $# < 2 || $# > 3 )); then
        echo "Usage: move_job_re <jobid_regex> <queue> <?timeLimit>"
        return 1
    fi

    local jobid_regex=$1
    local queue=$2
    local timeLimit="${3:-0}"

    local jobids=($(squeue -u arjk -h -o "%A" | grep -E "$jobid_regex"))

    if (( ${#jobids[@]} == 0 )); then
        echo "No jobs found matching regex: $jobid_regex"
        return 1
    fi

    for jobid in "${jobids[@]}"; do
        move_job $jobid $queue $timeLimit
    done
}

sline() {
    if (( $# != 1 )); then
        echo "Usage: sline <jobid>"
        return 1
    fi
    local jobid=$1
    sacct -j $jobid -o submitline -P
}

nvstats() {
    nvidia-smi --query-gpu=timestamp,name,pstate,temperature.gpu,utilization.gpu,utilization.memory,memory.used,memory.total --format csv -l 1
}

# gcloud
if [ -f $HOME/software/google-cloud-sdk/path.zsh.inc ]; then
    . $HOME/software/google-cloud-sdk/path.zsh.inc
fi
if [ -f $HOME/software/google-cloud-sdk/completion.zsh.inc ]; then
    . $HOME/software/google-cloud-sdk/completion.zsh.inc
fi
