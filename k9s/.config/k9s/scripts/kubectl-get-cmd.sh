#!/usr/bin/env bash

namespace=$1
resource_name=$2
name=$3

kubectl_get_command=$(echo "kubectl get $resource_name $name -n $namespace")

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "$kubectl_get_command" | pbcopy
else
    echo "$kubectl_get_command" | xclip -sel clip
fi

echo "\"$kubectl_get_command\" has been copied to clipboard" |& less
