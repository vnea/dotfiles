#!/usr/bin/env bash

# shellcheck source=/dev/null
source ~/dotfiles/aliases/utils/open.sh

function j() {
    jira_issue_id="$(git branch --show-current | rg -o '(^\w+-\d+)')"

    if [[ -n $jira_issue_id ]]; then
        [[ -z $ALIASES_JIRA_URL ]] && { echo 'The environment variable "ALIASES_JIRA_URL" must be defined.'; return 1; }
        _open_link "$ALIASES_JIRA_URL/browse/$jira_issue_id"
    fi
}
