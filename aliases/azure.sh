#!/usr/bin/env bash

# TODO: to refactor like gitlab.sh

#login_token=""
#
#function get_vcsinfo() {
#  if [ -z "$vsc_info_root_path" ]
#  then
#    current_directory=$(pwd)
#  else
#    current_directory="$vsc_info_root_path"
#  fi
#
#  vcs_info_file="${current_directory}/.vcs_info.json"
#  if [ ! -f "${vcs_info_file}" ]; then
#      vcs_info_file="${current_directory}/vcs_info.json"
#  fi
#
#  organization_name=$(jq -r .organization_name "${vcs_info_file}")
#  project_id=$(jq -r .project_id "${vcs_info_file}")
#  project_name=$(jq -r .project_name "${vcs_info_file}")
#  repository_id=$(jq -r .repository_id "${vcs_info_file}")
#  repository_name=$(basename "$current_directory")
#  current_branch=$(git rev-parse --abbrev-ref HEAD)
#  default_branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed "s@^refs/remotes/origin/@@")
#  pr_default_target_branch=$(jq -r .pr_default_target_branch "${vcs_info_file}")
#  if [ "$pr_default_target_branch" = null ]
#  then
#    pr_default_target_branch="$default_branch"
#  fi
#}
#
#function glab() {
#  get_vcsinfo
#  (&>/dev/null xdg-open "https://dev.azure.com/$organization_name/$project_name/_git/$repository_name" &)
#}
#
#function glabp() {
#  get_vcsinfo
#  (&>/dev/null xdg-open "https://dev.azure.com/$organization_name/$project_name/_build" &)
#}
#
#function glabb() {
#  get_vcsinfo
#  (&>/dev/null xdg-open "https://dev.azure.com/$organization_name/$project_name/_git/$project_name/branches?_a=all" &)
#}
#
#function mra() {
#    get_vcsinfo
#    (&>/dev/null xdg-open "https://dev.azure.com/$organization_name/$project_name/_git/$repository_name/pullrequests?_a=active" &)
#}
#
#function print_current_pr() {
#    get_vcsinfo
#
#    if [[ "$current_branch" != "$default_branch" ]]
#    then
#        local azure_env=$(curl --silent -H "Accept: application/xml" --user "$login_token" "https://dev.azure.com/$organization_name/$project_id/_apis/git/repositories/$repository_id/pullRequests?searchCriteria.sourceRefName=refs/heads/$current_branch&searchCriteria.status=active" | jq -r '.value[0].pullRequestId')
#        echo "pr$azure_env"
#    fi
#}
#
#function pr() {
#    get_vcsinfo
#
#    if [[ "$current_branch" != "$default_branch" ]]
#    then
#        local azure_env=$(curl --silent -H "Accept: application/xml" --user "$login_token" "https://dev.azure.com/$organization_name/$project_id/_apis/git/repositories/$repository_id/pullRequests?searchCriteria.sourceRefName=refs/heads/$current_branch&searchCriteria.status=active" | jq -r '.value[0].pullRequestId')
#        echo "pr$azure_env" | tr -d '\n' | xclip -sel clip
#        local branch_name_and_pull_request_id="[$current_branch/$azure_env]"
#        echo "PR ID for $branch_name_and_pull_request_id has been copied into clipboard."
#    fi
#}
#
#function mrc() {
#    get_vcsinfo
#
#    if [[ "$current_branch" != "$default_branch" ]]
#    then
#        local azure_env=$(curl --silent -H "Accept: application/xml" --user "$login_token" "https://dev.azure.com/$organization_name/$project_id/_apis/git/repositories/$repository_id/pullRequests?searchCriteria.sourceRefName=refs/heads/$current_branch&searchCriteria.status=active" | jq -r '.value[0].pullRequestId')
#        if [ "$azure_env" = null ]
#        then
#            local new_pr_link="https://dev.azure.com/$organization_name/$project_name/_git/$repository_name/pullrequestcreate?sourceRef=$current_branch&targetRef=$pr_default_target_branch&sourceRepositoryId=$repository_id&targetRepositoryId=$repository_id"
#            (&>/dev/null xdg-open "$new_pr_link" &)
#        else
#            (&>/dev/null xdg-open "https://dev.azure.com/$organization_name/$project_name/_git/$repository_name/pullrequest/$azure_env" &)
#        fi
#    fi
#}
#
#function mrs() {
#    get_vcsinfo
#    current_branch=$(git branch -a | grep -v "$default_branch" | sed "s/remotes\/origin\///g" | sed "s/\s//g" | sed "s/*//" | sort | uniq)
#    current_branch=$(echo $current_branch | fzf)
#
#    if [[ "$current_branch" != "$default_branch" ]]
#    then
#        local azure_env=$(curl --silent --user "$login_token" "https://dev.azure.com/$organization_name/$project_id/_apis/git/repositories/$repository_id/pullRequests?searchCriteria.sourceRefName=refs/heads/$current_branch&searchCriteria.status=active" | jq -r '.value[0].pullRequestId')
#        if [ "$azure_env" = null ]
#        then
#            local new_pr_link="https://dev.azure.com/$organization_name/$project_name/_git/$repository_name/pullrequestcreate?sourceRef=$current_branch&targetRef=$pr_default_target_branch&sourceRepositoryId=$repository_id&targetRepositoryId=$repository_id"
#            (&>/dev/null xdg-open "$new_pr_link" &)
#        else
#            (&>/dev/null xdg-open "https://dev.azure.com/$organization_name/$project_name/_git/$repository_name/pullrequest/$azure_env" &)
#        fi
#    fi
#}
#
##function glabb() {
#    #https://dev.azure.com/la-parisienne-git/OCPAS/_git/ocpas?path=%2F&version=GBadr-faq-boostrap-front&_a=contents
##}
#
## Azure portal
#function aa() {
#    get_vcsinfo
#
#    if [[ "$current_branch" != "$default_branch" ]]
#    then
#        local azure_env=$(curl --silent -H "Accept: application/xml" --user "$login_token" "https://dev.azure.com/$organization_name/$project_id/_apis/git/repositories/$repository_id/pullRequests?searchCriteria.sourceRefName=refs/heads/$current_branch&searchCriteria.status=active" | jq -r '.value[0].pullRequestId')
#        azure_env="pr$azure_env"
#    elif [[ "$current_branch" == "$default_branch" ]]
#    then
#        local azure_env=dev
#    fi
#
#    if [ "$azure_env" = null ] || [ -z "$azure_env" ]
#    then
#        echo "No Azure ressource group associated to the branch [$current_branch]."
#    else
#        local branch_name_and_pull_request_id="[$current_branch/$azure_env]"
#        local chosen_action=$(echo "01. Copy PR ID
#02. Go to Azure RG
#03. Copy key Event Grid (EG)
#04. Copy key Azure Function (AZF)
#05. Copy key Cosmos DB
#06. Copy connection string Cosmos DB
#07. Copy URL Event Grid (EG)
#08. Copy URL API (AS)
#09. Copy URL Azure Function (AZF)
#10. Copy URL Cosmos DB
#11. Print logs Azure Function (AZF)
#" | rofi -dmenu -i -p "Select Azure action for $branch_name_and_pull_request_id")
#        if [[ "$chosen_action" == 01* ]]
#        then
#            echo $azure_env | xclip -sel clip
#            echo "PR ID for $branch_name_and_pull_request_id has been copied into clipboard."
#        elif [[ "$chosen_action" == 02* ]]
#        then
#            (&>/dev/null xdg-open "https://portal.azure.com/#@protegysgroup.onmicrosoft.com/resource/subscriptions/dd06bc2c-1e4c-439e-8e85-108420781628/resourceGroups/wkm-rg-ocpas-westeu-$azure_env/overview" &)
#        elif [[ "$chosen_action" == 03* ]]
#        then
#            echo "Retrieving access key of Event Grid in progress..."
#            az eventgrid topic key list --name wkm-egt-ocpas-westeu-$(echo $azure_env) --resource-group wkm-rg-ocpas-westeu-$(echo $azure_env) | jq -r '.key1' | tr -d '\n' | xclip -sel clip
#            echo "The access key of Event Grid for $branch_name_and_pull_request_id has been copied into clipboard."
#        elif [[ "$chosen_action" == 04* ]]
#        then
#            echo "Retrieving access key of Azure Function in progress..."
#            az functionapp keys list --name wkm-azf-ocpas-ocr-westeu-$(echo $azure_env) --resource-group wkm-rg-ocpas-westeu-$(echo $azure_env) | jq -r '.masterKey' | tr -d '\n' | xclip -sel clip
#            echo "The access key of Azure Function for $branch_name_and_pull_request_id has been copied into clipboard."
#        elif [[ "$chosen_action" == 05* ]]
#        then
#            echo "Retrieving access key of Cosmos DB in progress..."
#            az cosmosdb keys list --name wkm-cbd-ocpas-oc-westeu-$(echo $azure_env) --resource-group wkm-rg-ocpas-westeu-$(echo $azure_env) | jq -r '.primaryMasterKey' | tr -d '\n' | xclip -sel clip
#            echo "The access key of Cosmos DB for $branch_name_and_pull_request_id has been copied into clipboard."
#        elif [[ "$chosen_action" == 06* ]]
#        then
#            echo "Retrieving connection string of Cosmos DB in progress..."
#            az cosmosdb keys list --name wkm-cbd-ocpas-oc-westeu-$(echo $azure_env) --resource-group wkm-rg-ocpas-westeu-$(echo $azure_env) --type connection-strings | jq -r '.connectionStrings[0].connectionString' | tr -d '\n' | xclip -sel clip
#            echo "The connection string of Cosmos DB for $branch_name_and_pull_request_id has been copied into clipboard."
#        elif [[ "$chosen_action" == 07* ]]
#        then
#            echo "https://wkm-egt-ocpas-westeu-$azure_env.westeurope-1.eventgrid.azure.net/api/events" | xclip -sel clip
#            echo "The URL of Event Grid for $branch_name_and_pull_request_id has been copied into clipboard."
#        elif [[ "$chosen_action" == 08* ]]
#        then
#            echo "https://api.$azure_env.ocpas.wakam.com/swagger" | xclip -sel clip
#            echo "The URL of API for $branch_name_and_pull_request_id has been copied into clipboard."
#        elif [[ "$chosen_action" == 09* ]]
#        then
#            echo "https://wkm-azf-ocpas-ocr-westeu-$azure_env.azurewebsites.net" | xclip -sel clip
#            echo "The URL of Azure Function for $branch_name_and_pull_request_id has been copied into clipboard."
#        elif [[ "$chosen_action" == 10* ]]
#        then
#            echo "https://wkm-azf-ocpas-ocr-westeu-$azure_env.documents.azure.com" | xclip -sel clip
#            echo "The URL of Cosmos DB for $branch_name_and_pull_request_id has been copied into clipboard."
#        elif [[ "$chosen_action" == 11* ]]
#        then
#            echo "Retrieving logs of Azure Function for $branch_name_and_pull_request_id in progress..."
#            az webapp log tail --name wkm-azf-ocpas-ocr-westeu-$(echo $azure_env) --resource-group wkm-rg-ocpas-westeu-$(echo $azure_env)
#        fi
#    fi
#}
#
##case $space in
##[1-6]*)
##  Message="All is quiet."
##  ;;
##[7-8]*)
##  Message="Start thinking about cleaning out some stuff.  There's a partition that is $space % full."
##  ;;
##9[1-8])
##  Message="Better hurry with that new disk...  One partition is $space % full."
##  ;;
##99)
##  Message="I'm drowning here!  There's a partition at $space %!"
##  ;;
##*)
##  Message="I seem to be running with an nonexistent amount of disk space..."
##  ;;
##esac
