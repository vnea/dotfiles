#!/usr/bin/env bash

# shellcheck source=/dev/null
source ~/dotfiles/aliases/utils/open.sh

function _load_gitlab_project_info() {
  if [ -z "$GITLAB_PROJECT_INFO_ROOT_PATH" ]
  then
      echo "You must define the variable 'GITLAB_PROJECT_INFO_ROOT_PATH' (e.g. with '.envrc')."
      return 1
  else
    current_directory="$GITLAB_PROJECT_INFO_ROOT_PATH"
  fi

  local gitlab_project_info_file_name=".gitlab-project-info.json"
  local gitlab_project_info_file="${current_directory}/$gitlab_project_info_file_name"
  if [ ! -f "$gitlab_project_info_file" ]; then
      echo "You must create a file '$gitlab_project_info_file_name' in your Git repository."
      return 1
  fi

  gitlab_domain=$(jq -r .domain "${gitlab_project_info_file}")
  gitlab_project_id=$(jq -r .project_id "${gitlab_project_info_file}")
  gitlab_project_path=$(jq -r .project_path "${gitlab_project_info_file}")
  gitlab_project_web_url="https://$gitlab_domain/$gitlab_project_path"

  gitlab_access_token=$(jq -r .access_token "${gitlab_project_info_file}")

  gitlab_default_branch=$(jq -r .default_branch "${gitlab_project_info_file}")
  gitlab_current_branch=$(git rev-parse --abbrev-ref HEAD)

  return 0
}

function _cleanup_gitlab()
{
    unset gitlab_domain
    unset gitlab_project_id
    unset gitlab_project_path
    unset gitlab_project_web_url
    unset gitlab_access_token
    unset gitlab_default_branch
    unset gitlab_current_branch
}

function glab() {
    trap _cleanup_gitlab EXIT

    if ! _load_gitlab_project_info; then
      return
    fi

    _open_link "$gitlab_project_web_url"
}

function glabb() {
    trap _cleanup_gitlab EXIT

    if ! _load_gitlab_project_info; then
      return
    fi

    _open_link "$gitlab_project_web_url/-/branches"
}

function glabc() {
    trap _cleanup_gitlab EXIT

    if ! _load_gitlab_project_info; then
      return
    fi

    _open_link "$gitlab_project_web_url/-/commits"
}

function glabe() {
    trap _cleanup_gitlab EXIT

    if ! _load_gitlab_project_info; then
      return
    fi

    _open_link "$gitlab_project_web_url/-/environments"
}

function glabp() {
    trap _cleanup_gitlab EXIT

    if ! _load_gitlab_project_info; then
      return
    fi

    _open_link "$gitlab_project_web_url/-/pipelines"
}

function mra() {
    trap _cleanup_gitlab EXIT

    if ! _load_gitlab_project_info; then
      return
    fi

    _open_link "$gitlab_project_web_url/-/merge_requests"
}

function mrc() {
    trap _cleanup_gitlab EXIT

    if ! _load_gitlab_project_info; then
      return
    fi

    if [[ "$gitlab_current_branch" != "$gitlab_default_branch" ]]
    then
        local mr_api_result
        mr_api_result=$(
          curl -s "https://$gitlab_domain/api/v4/projects/$gitlab_project_id/merge_requests?source_branch=$gitlab_current_branch&private_token=$gitlab_access_token" \
          | sed 's/\\[nr]//g' \
          | jq ".[].web_url" \
          | sed 's/"//g'
        )

        if [ "$mr_api_result" = "" ]
        then
            local new_mr_link="$gitlab_project_web_url/-/merge_requests/new?merge_request%5Bsource_branch%5D=$gitlab_current_branch"
            _open_link "$new_mr_link"
        else
           _open_link "$mr_api_result"
        fi
    fi
}

function mrcp() {
    trap _cleanup_gitlab EXIT

    if ! _load_gitlab_project_info; then
      return
    fi

    if [[ "$gitlab_current_branch" != "$gitlab_default_branch" ]]
    then
        local mr_api_result
        mr_api_result=$(
          curl -s "https://$gitlab_domain/api/v4/projects/$gitlab_project_id/merge_requests?source_branch=$gitlab_current_branch&private_token=$gitlab_access_token" \
          | sed 's/\\[nr]//g' \
          | jq ".[].web_url" \
          | sed 's/"//g'
        )

        if [ "$mr_api_result" != "" ]
        then
            _open_link "$mr_api_result/pipelines"
        fi
    fi
}

function mrs() {
    trap _cleanup_gitlab EXIT

    if ! _load_gitlab_project_info; then
      return
    fi

    local gitlab_current_branch_search
    gitlab_current_branch_search=$(
      git branch -a \
      | grep -v "$gitlab_default_branch" \
      | sed "s/remotes\/origin\///g" \
      | sed "s/[[:space:]]//g" \
      | sed "s/*//" \
      | sort \
      | uniq
    )
    gitlab_current_branch_search=$(echo "${gitlab_current_branch_search}" | fzf)

    if [ "$gitlab_current_branch_search" != "" ]
    then
        local mr_api_result
        mr_api_result=$(
          curl -s "https://$gitlab_domain/api/v4/projects/$gitlab_project_id/merge_requests?source_branch=$gitlab_current_branch_search&private_token=$gitlab_access_token" \
          | sed 's/\\[nr]//g' \
          | jq ".[].web_url" \
          | sed 's/"//g'
        )

        if [ "$mr_api_result" = "" ]
        then
            local new_mr_link="$gitlab_project_web_url/-/merge_requests/new?merge_request%5Bsource_branch%5D=$gitlab_current_branch_search"
            _open_link "$new_mr_link"
        else
            _open_link "$mr_api_result"
        fi
    fi
}
