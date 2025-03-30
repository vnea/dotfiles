#!/usr/bin/env bash

function _open_link() {
    link=$1

    if [[ "$(uname)" == "Darwin" ]]; then
        open "$link" &>/dev/null
    else
        xdg-open "$link" &>/dev/null
    fi
}

function j() {
    jira_issue_id="$(git branch --show-current | rg -o '(^\w+-\d+)')"

    if [[ -n $jira_issue_id ]]; then
        [[ -z $ALIASES_JIRA_URL ]] && { echo 'The environment variable "ALIASES_JIRA_URL" must be defined.'; return 1; }
        _open_link "$ALIASES_JIRA_URL/browse/$jira_issue_id"
    fi
}
