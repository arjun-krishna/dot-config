move_job() {
    if [ $# -ne 2 ]; then
        echo "Usage: move_job <jobid> <queue>"
    fi
    local jobid=$1
    local queue=$2
    local valid_queue=("l" "m" "h")
    if [[ ! "${valid_queue[@]} " =~ " $queue " ]]; then
        echo "invalid queue target. valid options are: ${valid_queue[*]}"
        return 1
    fi
    if [ "$queue" == "l" ]; then
        scontrol update jobid=$jobid partition=batch qos=normal timeLimit=24:00:00
    elif [ "$queue" == "h" ]; then
        scontrol update jobid=$jobid partition=dineshj-compute qos=dj-high timeLimit=24:00:00
    else
        scontrol update jobid=$jobid partition=dineshj-compute qos=dj-med timeLimit=12:00:00
    fi
}

sline() {
    if [ $# -ne 1 ]; then
        echo "Usage: sline <jobid>"
    fi
    local jobid=$1
    sacct -j $jobid -o submitline -P
}
