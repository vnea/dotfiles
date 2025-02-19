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
