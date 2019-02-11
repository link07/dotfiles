#!/bin/bash
tmp="$(tempfile)"
one_down=""
nine_down=""

trap cleanup SIGINT SIGTERM

function ping_test()
{
    if ping -q -c 1 -W 1 "$1" >/dev/null; then
        if ! [ -z "$2" ]; then
            eval "$2=''"
        fi

        echo "UP: $1"
    else
        if ! [ -z "$2" ]; then
            if [ "${!2}" == "" ]; then
                eval "$2='Down since $(date "+%_I:%M:%S %p %_m/%_d")'"
            fi
        fi

        echo "DOWN: $1 - ${!2}"
    fi
}

function do_ping()
{
    ping_test 192.168.1.1
    ping_test 192.168.1.25
    #ping_test "d1.dns.local"
    ping_test 192.168.100.1

    echo;

    ping_test 1.1.1.1 one_down
    ping_test 9.9.9.9 nine_down
}

function cleanup()
{
    rm "$tmp"
    exit 0
}

# note: watching a file instead of just directly printing to screen
# because then the display doesn't flicker as lines are printed
# which makes having it in the corner of a monitor much less annoying
watch cat "$tmp" &

while true; do
    echo "Time: $(date "+%_I:%M:%S %p %_m/%_d")" > "$tmp"
    echo >> "$tmp"

    do_ping >> "$tmp"

    sleep 10
done