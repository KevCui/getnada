#!/usr/bin/env bash
#
# A script to use getnada temp mail service in terminal
#
#/ Usage:
#/   ./getnada.sh [-i <inbox>|-m <uid>|-d <uid>|-s]
#/
#/ Options:
#/   no option        Optional, randamly get an inbox
#/   -i <inbox>       Optional, get an inbox by its mail address
#/   -m <uid>         Optional, show mail by its uid
#/   -d <uid>         Optional, delete mail by its uid
#/   -s               Optional, show available domains
#/   -h | --help      Display this help message
#/
#/ Examples:
#/   \e[32m- Generate a random inbox:\e[0m
#/     ~$ ./getnada.sh
#/
#/   \e[32m- Get mails in test@getnada.com:\e[0m
#/     ~$ ./getnada.sh \e[33m-i 'test@getnada.com'\e[0m
#/
#/   \e[32m- Show mail uUa4V5Hjmkqf9O detail: \e[0m
#/     ~$ ./getnada.sh \e[33m-m uUa4V5Hjmkqf9O\e[0m
#/
#/   \e[32m- Delete mail uUa4V5Hjmkqf9O: \e[0m
#/     ~$ ./getnada.sh \e[33m-d uUa4V5Hjmkqf9O\e[0m
#/
#/   \e[32m- Show all available domains: \e[0m
#/     ~$ ./getnada.sh \e[33m-s\e[0m

set -e
set -u

usage() {
    # Display usage message
    printf "\n%b\n" "$(grep '^#/' "$0" | cut -c4-)" && exit 0
}

set_var() {
    # Declare variables
    _HOST="https://getnada.com/api/v1"
    _INBOX_URL="$_HOST/inboxes"
    _MESSAGE_URL="$_HOST/messages"
    _DOMAIN_URL="$_HOST/domains"
}

set_command() {
    # Declare commands
    _CURL="$(command -v curl)" || command_not_found "curl" "https://curl.haxx.se/download.html"
    _JQ="$(command -v jq)" || command_not_found "jq" "https://stedolan.github.io/jq/"
    _W3M="$(command -v w3m)" || command_not_found "w3m" "http://w3m.sourceforge.net/"
    _FAKER="$(command -v faker-cli)" || command_not_found "faker-cli" "https://github.com/lestoni/faker-cli"
}

set_args() {
    # Declare arguments
    expr "$*" : ".*--help" > /dev/null && usage
    while getopts ":hsi:m:d:" opt; do
        case $opt in
            i)
                _INBOX="$OPTARG"
                ;;
            m)
                _MESSAGE_UID="$OPTARG"
                _FLAG_GET_MESSAGE=true
                ;;
            d)
                _MESSAGE_UID="$OPTARG"
                _FLAG_DELETE_MESSAGE=true
                ;;
            s)
                _FLAG_SHOW_DOMAIN=true
                ;;
            h)
                usage
                ;;
            \?)
                echo "Invalid option: -$OPTARG" >&2
                usage
                ;;
        esac
    done
}

command_not_found() {
    # Show command not found message
    # $1: command name
    # $2: installation URL
    printf "%b\n" '\033[31m'"$1"'\033[0m command not found!'
    [[ -n "${2:-}" ]] && printf "%b\n" 'Install from \033[31m'"$2"'\033[0m'
    exit 1
}

jq_format() {
    # Show result formated by jq
    # $1: response
    if $_JQ -e . >/dev/null 2>&1 <<<"$1"; then
        echo "$1" | $_JQ
    else
        echo "$1"
    fi
}

fake_username () {
    # Create a fake user
    echo "$($_FAKER -n firstName).$($_FAKER -n lastName)" | sed -E 's/"//g' | tr '[:upper:]' '[:lower:]'
}

get_inbox() {
    # Get inbox by mailbox address
    # $1: address
    jq_format "$($_CURL -sSX GET "$_INBOX_URL/$1")"
}

get_message() {
    # Get message by uid
    # $1: uid
    $_W3M -T "text/html" <<< "$($_CURL -sSX GET "$_MESSAGE_URL/$1" | $_JQ -r '.html')"
}

delete_message() {
    # Delete message by uid
    # $1: uid
    jq_format "$($_CURL -sSX DELETE "$_MESSAGE_URL/$1")"
}

show_domain() {
    # Show available domains
    $_CURL -sSX GET "$_DOMAIN_URL" | $_JQ -r '.[].name'
}

show_random_domain() {
    # Show available domains in a random order
    show_domain | shuf
}

get_random_inbox() {
    # Get a randam inbox
    local u d
    u=$(fake_username)
    d=$(show_random_domain | tail -1)

    get_inbox "$u@$d"
    echo "$u@$d"
}

main() {
    set_args "$@"
    set_command
    set_var

    if [[ -z "$*" ]]; then
        get_random_inbox
    else
        [[ -n "${_FLAG_SHOW_DOMAIN:-}" ]] && show_domain
        [[ -n "${_INBOX:-}" ]] && get_inbox "$_INBOX"
        [[ "${_FLAG_GET_MESSAGE:-}" == true ]] && get_message "${_MESSAGE_UID:-}"
        [[ "${_FLAG_DELETE_MESSAGE:-}" == true ]] && delete_message "${_MESSAGE_UID:-}" && get_message "${_MESSAGE_UID:-}"
    fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
