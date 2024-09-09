move_job() {
    if [ $# -lt 2 ] || [ $# -gt 3 ]; then
        echo "Usage: move_job <jobid> <queue> <?timeLimit>"
    fi
    local jobid=$1
    local queue=$2
    local timeLimit="${3:-0}"
    local valid_queue=("l" "m" "h")
    if [[ ! " ${valid_queue[@]} " =~ " $queue " ]]; then
        echo "invalid queue target: $queue. valid options are: ${valid_queue[*]}"
        return 1
    fi
    local defaultTimeLimit
    case $queue in
        l)
            defaultTimeLimit="24:00:00"
            ;;
        h)
            defaultTimeLimit="24:00:00"
            ;;
        m)
            defaultTimeLimit="12:00:00"
            ;;
        *)
            echo "unexpected error."
            return 1
            ;;
    esac
    if [ "$timeLimit" = "0" ]; then
        timeLimit=$defaultTimeLimit
    fi
    if [ "$queue" == "l" ]; then
        scontrol update jobid=$jobid partition=batch qos=normal timeLimit=$timeLimit
    elif [ "$queue" == "h" ]; then
        scontrol update jobid=$jobid partition=dineshj-compute qos=dj-high timeLimit=$timeLimit
    else
        scontrol update jobid=$jobid partition=dineshj-compute qos=dj-med timeLimit=$timeLimit
    fi
}

sline() {
    if [ $# -ne 1 ]; then
        echo "Usage: sline <jobid>"
    fi
    local jobid=$1
    sacct -j $jobid -o submitline -P
}

alias ma="mamba activate"
alias tb="tensorboard --logdir . --port"
