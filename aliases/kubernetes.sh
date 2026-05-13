#!/usr/bin/env bash

alias ks='k9s -n "$(kubectl config view --minify --output 'jsonpath={..namespace}')"'

alias k=kubectl
alias kg="kubectl get"
alias kd="kubectl describe"

# Pod
alias kgp="kubectl get pods"
alias kdp="kubectl describe pods"

# Service
alias kgs="kubectl get svc"
alias kds="kubectl describe svc"

# HTTPRoute
alias kgh="kubectl get httproute"

# Ingress
alias kgi="kubectl get ingress"
alias kdi="kubectl describe ingress"

# Namespace
alias kgns="kubectl get namespaces"
alias kdns="kubectl describe namespace"
function kny() {
    local namespace
    namespace=$(kubectl config view --minify --output 'jsonpath={..namespace}' | tr -d '\n')

    if [[ "$(uname)" == "Darwin" ]]; then
        echo -n "$namespace" | pbcopy
    else
        echo -n "$namespace" | xclip -sel clip
    fi
}

# ConfigMap
alias kgcm="kubectl get configmaps"
alias kdcm="kubectl describe configmap"

# Secret
alias kgsec="kubectl get secret"
alias kdsec="kubectl describe secret"

# ExternalSecret
alias kges="kubectl get externalsecrets"
alias kdes="kubectl describe externalsecrets"

# Deployment
alias kgd="kubectl get deployment"
alias kdd="kubectl describe deployment"

# Tools for accessing all information
alias kga="kubectl get all"
alias kgaa="kubectl get all --all-namespaces"

# Logs
alias kl="kubectl logs"

# File copy
alias kcp="kubectl cp"

# Node
alias kgno="kubectl get nodes"
alias kdno="kubectl describe node"

# PVC
alias kgpvc="kubectl get pvc"
alias kdpvc="kubectl describe pvc"

# Service Account
alias kdsa="kubectl describe sa"

# DaemonSet
alias kgds="kubectl get daemonset"
alias kdds="kubectl describe daemonset"

# CronJob
alias kgcj="kubectl get cronjob"
alias kdcj="kubectl describe cronjob"

# Job
alias kgj="kubectl get job"
alias kej="kubectl edit job"
alias kdj="kubectl describe job"

alias kubectl="kubecolor"
compdef kubecolor=kubectl

# Source: https://github.com/luksa/kubectl-plugins/blob/master/kubectl-really-get-all
function kgetall() {
    RESOURCES=$(kubectl api-resources --verbs=list --namespaced -o name | tr "\n" ,)
    kubectl get "${RESOURCES%?}" --show-kind --ignore-not-found "$@"
}

# Source: https://github.com/ahmetb/kubectx/issues/313
function kns() {
  if namespace=$(< "$HOME/.local/share/kubectx-cache/$(kubectx -c)" fzf); then
      kubectl config set-context --current --namespace="$namespace";
      env=$(kubectl config current-context | sed "s/marketplace-//" | awk -F "-" '{ print $1 }')
      tmux rename-window "$env | $namespace"
  fi
}

function kc() {
  if kubectx; then
      env=$(kubectl config current-context | sed "s/marketplace-//" | awk -F "-" '{ print $1 }')
      tmux rename-window "$env"
  fi
}

# kns-update-cachen, source: https://github.com/ahmetb/kubectx/issues/313
function knu() {
  mkdir -p "$HOME/.local/share/kubectx-cache"
  kubectl get ns -o json | jq -r '.items[].metadata.name' > "$HOME/.local/share/kubectx-cache/$(kubectx -c)"
}
