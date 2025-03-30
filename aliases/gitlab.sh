#!/usr/bin/env bash
# shellcheck disable=SC2155
# SC2155: Declare and assign separately to avoid masking return values.

# shellcheck source=/dev/null
source ~/dotfiles/aliases/utils/open.sh

#########################
# Private functions
#########################
function _gitlab_check_env_variables() {
    [[ -z $ALIASES_GITLAB_ACCESS_TOKEN ]] && echo 'You must defined the variable "ALIASES_GITLAB_ACCESS_TOKEN".'
    [[ -z $ALIASES_GITLAB_DOMAIN ]] && echo 'You must defined the variable "ALIASES_GITLAB_DOMAIN".'
    [[ -z $ALIASES_GITLAB_PROJECT_PATH ]] && echo 'You must defined the variable "ALIASES_GITLAB_PROJECT_PATH".'
}

function _gitlab_get_current_branch() {
    git branch --show-current
}

function _gitlab_get_project_url() {
    echo "https://$ALIASES_GITLAB_DOMAIN/$ALIASES_GITLAB_PROJECT_PATH"
}

function _gitlab_get_default_branch() {
    git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'
}

function _gitlab_get_mr_info_by_source_branch() {
    local source_branch="$1"

    http --print b \
        "https://$ALIASES_GITLAB_DOMAIN/api/v4/projects/$(echo -n "$ALIASES_GITLAB_PROJECT_PATH" | jq -sRr @uri)/merge_requests" \
        source_branch=="$source_branch" \
        private_token=="$ALIASES_GITLAB_ACCESS_TOKEN" \
        | sed 's/\\[nr]//g' \
        | jq ".[].web_url" \
        | sed 's/"//g'
}

#########################
# Public functions
#########################
function glab() {
    if local check_result=$(_gitlab_check_env_variables) && [[ -n $check_result ]]; then
        echo "$check_result"; return
    fi

    _open_link "$(_gitlab_get_project_url)"
}

function glabb() {
    if local check_result=$(_gitlab_check_env_variables) && [[ -n $check_result ]]; then
        echo "$check_result"; return
    fi

    _open_link "$(_gitlab_get_project_url)/-/branches"
}

function glabc() {
    if local check_result=$(_gitlab_check_env_variables) && [[ -n $check_result ]]; then
        echo "$check_result"; return
    fi

    _open_link "$(_gitlab_get_project_url)/-/commits"
}

function glabe() {
    if local check_result=$(_gitlab_check_env_variables) && [[ -n $check_result ]]; then
        echo "$check_result"; return
    fi

    _open_link "$(_gitlab_get_project_url)/-/environments"
}

function glabp() {
    if local check_result=$(_gitlab_check_env_variables) && [[ -n $check_result ]]; then
        echo "$check_result"; return
    fi

    _open_link "$(_gitlab_get_project_url)/-/pipelines"
}

function mra() {
    if local check_result=$(_gitlab_check_env_variables) && [[ -n $check_result ]]; then
        echo "$check_result"; return
    fi

    _open_link "$(_gitlab_get_project_url)/-/merge_requests"
}

function mrc() {
    if local check_result=$(_gitlab_check_env_variables) && [[ -n $check_result ]]; then
        echo "$check_result"; return
    fi

    [[ "$(_gitlab_get_current_branch)" == "$(_gitlab_get_default_branch )" ]] && return

    local mr_api_result=$(_gitlab_get_mr_info_by_source_branch "$(_gitlab_get_current_branch)")

    if [[ -z "$mr_api_result" ]]; then
        _open_link "$(_gitlab_get_project_url)/-/merge_requests/new?merge_request%5Bsource_branch%5D=$(_gitlab_get_current_branch)"
    else
        _open_link "$mr_api_result"
    fi
}

function mrcp() {
    if local check_result=$(_gitlab_check_env_variables) && [[ -n $check_result ]]; then
        echo "$check_result"; return
    fi

    [[ "$(_gitlab_get_current_branch)" == "$(_gitlab_get_default_branch )" ]] && return

    local mr_api_result=$(_gitlab_get_mr_info_by_source_branch "$(_gitlab_get_current_branch)")

    if [[ -z "$mr_api_result" ]]; then
        echo "There is no opened merge request for the current branch."
    else
        _open_link "$mr_api_result/pipelines"
    fi
}

function mrs() {
    if local check_result=$(_gitlab_check_env_variables) && [[ -n $check_result ]]; then
        echo "$check_result"; return
    fi

    local gitlab_current_branch_search=$(
        git branch -a \
            | grep -v "$(_gitlab_get_current_branch)" \
            | sed 's/remotes\/origin\///g' \
            | sed 's/[[:space:]]//g' \
            | sed 's/*//' \
            | sort \
            | uniq \
            | fzf
        )

        [[ -z "$gitlab_current_branch_search" ]] && return

        local mr_api_result=$(_gitlab_get_mr_info_by_source_branch "$gitlab_current_branch_search")

        if [[ -z "$mr_api_result" ]]; then
            _open_link "$(_gitlab_get_project_url)/-/merge_requests/new?merge_request%5Bsource_branch%5D=$gitlab_current_branch_search"
        else
            _open_link "$mr_api_result"
        fi
}
