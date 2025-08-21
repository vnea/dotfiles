#!/usr/bin/env bash
# shellcheck disable=SC2155
# SC2155: Declare and assign separately to avoid masking return values.

# shellcheck source=/dev/null
source ~/dotfiles/aliases/utils/open.sh

alias gci="/opt/homebrew/bin/glab ci view"

#########################
# Private functions
#########################
function _gitlab_get_fqdn() {
    git ls-remote --get-url origin | rg --only-matching "^git@(.+):.+.git" --replace '$1'
}

function _gitlab_get_project_path() {
    git ls-remote --get-url origin | rg --only-matching "^git@.+:(.+).git" --replace '$1'
}

function _gitlab_get_current_branch() {
    git branch --show-current
}

function _gitlab_get_project_url() {
    echo "https://$(_gitlab_get_fqdn)/$(_gitlab_get_project_path)"
}

function _gitlab_get_default_branch() {
    git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'
}

function _gitlab_get_mr_info_by_source_branch() {
    local source_branch="$1"

    http --print b \
        "https://$(_gitlab_get_fqdn)/api/v4/projects/$(echo -n "$(_gitlab_get_project_path)" | jq -sRr @uri)/merge_requests" \
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
    _open_link "$(_gitlab_get_project_url)"
}

function glabb() {
    _open_link "$(_gitlab_get_project_url)/-/branches"
}

function glabc() {
    _open_link "$(_gitlab_get_project_url)/-/commits"
}

function glabe() {
    _open_link "$(_gitlab_get_project_url)/-/environments"
}

function glabp() {
    _open_link "$(_gitlab_get_project_url)/-/pipelines"
}

function mra() {
    _open_link "$(_gitlab_get_project_url)/-/merge_requests"
}

function mrc() {
    [[ "$(_gitlab_get_current_branch)" == "$(_gitlab_get_default_branch )" ]] && return

    local mr_api_result=$(_gitlab_get_mr_info_by_source_branch "$(_gitlab_get_current_branch)")
    _open_link "${mr_api_result:-$(_gitlab_get_project_url)/-/merge_requests/new?merge_request%5Bsource_branch%5D=$(_gitlab_get_current_branch)}"
}

function mrcp() {
    [[ "$(_gitlab_get_current_branch)" == "$(_gitlab_get_default_branch )" ]] && return

    local mr_api_result=$(_gitlab_get_mr_info_by_source_branch "$(_gitlab_get_current_branch)")
    # shellcheck disable=SC2015
    [[ -z "$mr_api_result" ]] && echo "There is no opened merge request for the current branch." || _open_link "$mr_api_result/pipelines"
}

function mrs() {
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
    _open_link "${mr_api_result:-$(_gitlab_get_project_url)/-/merge_requests/new?merge_request%5Bsource_branch%5D=$gitlab_current_branch_search}"
}
