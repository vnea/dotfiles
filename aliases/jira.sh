#!/usr/bin/env bash

# shellcheck source=/dev/null
source ~/dotfiles/aliases/utils/open.sh

function j() {
    local jira_issue_id=$1
    [[ -z $jira_issue_id ]] && jira_issue_id="$(git branch --show-current | rg --only-matching '(^\w+-\d+)')"

    if [[ -n $jira_issue_id ]]; then
        [[ -z $ALIASES_JIRA_URL ]] && { echo 'The environment variable "ALIASES_JIRA_URL" must be defined.'; return 1; }
        _open_link "$ALIASES_JIRA_URL/browse/$jira_issue_id"
    fi
}
