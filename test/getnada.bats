#!/usr/bin/env bats
#
# How to run:
#   ~$ bats test/getnada.bats

BATS_TEST_SKIPPED=

setup() {
    _SCRIPT="./getnada.sh"
    _JQ="$(command -v jq)"
    _FAKER="$(command -v faker-cli)"

    source $_SCRIPT
}

@test "CHECK: command_not_found()" {
    run command_not_found "bats"
    [ "$status" -eq 1 ]
    [ "$output" = "[31mbats[0m command not found!" ]
}

@test "CHECK: command_not_found(): show where-to-install" {
    run command_not_found "bats" "batsland"
    [ "$status" -eq 1 ]
    [ "${lines[0]}" = "[31mbats[0m command not found!" ]
    [ "${lines[1]}" = "Install from [31mbatsland[0m" ]
}

@test "CHECK: jq_format(): correct format" {
    json='{"left":"right"}'
    result="$(echo "$json" | $_JQ)"
    run jq_format "$json"
    [ "$status" -eq 0 ]
    [ "$output" = "$result" ]
}

@test "CHECK: jq_format(): wrong format" {
    json='not found'
    run jq_format "$json"
    [ "$status" -eq 0 ]
    [ "$output" = "$json" ]
}

@test "CHECK: fake_username()" {
    contain_str() {
        [[ $1 =~ ^[a-zA-Z]+\.[a-zA-Z]+$ ]] && echo "true" || echo "false"
    }
    run fake_username
    [ "$status" -eq 0 ]
    [ $(contain_str "$output") = "true" ]
}

@test "CHECK: get_random_inbox()" {
    fake_username() {
        echo "JackMe"
    }
    show_random_domain() {
        echo "gmail.com"
        echo "msn.com"
        echo "test.com"
    }
    get_inbox() {
        echo "show inbox json"
    }
    run get_random_inbox
    echo $output > log
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "show inbox json" ]
    [ "${lines[1]}" = "Inbox: JackMe@test.com" ]
}
