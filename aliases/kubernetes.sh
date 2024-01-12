#!/usr/bin/env bash

alias kc="kubectx"

alias kubectl="kubecolor"
compdef kubecolor=kubectl


function ku {
    export KUBECONFIG=$(ls -1 ~/.kube/*.conf | awk '{print $NF}' | fzf)
}

function kd {
    unset KUBECONFIG
}

