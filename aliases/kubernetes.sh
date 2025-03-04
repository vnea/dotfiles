#!/usr/bin/env bash

alias kc="kubectx"
alias ks="k9s"

alias kubectl="kubecolor"
compdef kubecolor=kubectl

# Source: https://github.com/luksa/kubectl-plugins/blob/master/kubectl-really-get-all
function kgetall() {
    RESOURCES=$(kubectl api-resources --verbs=list --namespaced -o name | tr "\n" ,)
    kubectl get ${RESOURCES%?} --show-kind --ignore-not-found $@
}

# Source: https://github.com/ahmetb/kubectx/issues/313
function kns() {
  if namespace=$(< "$HOME/.local/share/kubectx-cache/$(kubectx -c)" fzf); then
      kubectl config set-context --current --namespace="$namespace";
  fi
}

# Source: https://github.com/ahmetb/kubectx/issues/313
function kns-update-cache() {
  mkdir -p "$HOME/.local/share/kubectx-cache"
  kubectl get ns -o json | jq -r '.items[].metadata.name' > "$HOME/.local/share/kubectx-cache/$(kubectx -c)"
}
