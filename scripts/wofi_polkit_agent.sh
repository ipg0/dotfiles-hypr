#!/bin/sh

case "$*" in 'h'|'help'|'-h'|'-help'|'--help')
    echo 'Usage: rofi-polkit-agent [ROFI_OPTIONS]...
Polkit agent using rofi for GUI.

Start the polkit agent, with default options :
  rofi-polkit-agent

Start the polkit agent, with any additional argument passed directly to rofi :
  rofi-polkit-agent -theme PATH -monitor NUM
'
esac

if test "$1" != '_CALLED_INTERNALLY'; then

    prepParams() { for i in "$@"; do printf "'%s' " "$i"; done }
    parameters="$(prepParams "$@")"

    exec cmd-polkit-agent -s -c "$0 _CALLED_INTERNALLY $parameters*"
    # exec cmd-polkit-agent -s -c 'rofi-polkit-agent _CALLED_INTERNALLY'
else
    # Remove $1 (_CALLED_INTERNALLY) from parameter array
    shift 1

    # Read incoming messages one by one (line by line)
    # from stdin to variable $msg
    while read -r msg; do
        #  --- shellcheck disable=SC2210
        if echo "$msg" | jq -e '.action == "request password"' 1>/dev/null 2>/dev/null
        then
            # Parse msg fields
            prompt="$( printf '%s' "$msg" | jq -rc '.prompt // "Password:"')"
            message="$(printf '%s' "$msg" | jq -rc '.message // "No message given!"')"

            # Request a password prompt from rofi
            response="$(printf '' | rofi  -dmenu -p "$prompt" \
                -mesg "$message" -password -no-fixed-num-lines "$@")"

            # Cancel authentication if no password was given,
            # otherwise respond with given password
            if test -z "$response"
            then echo '{"action":"cancel"}'
            else echo "{\"action\":\"authenticate\",\"password\": \"$response\"}"
            fi
        fi
    done
fi
