#!/bin/bash

USER=$1

if [ -z $USER ]; then
    echo "missing args"
    exit 0
fi

kubectl config set-credentials ${USER} --client-certificate ./${USER}/${USER}.crt --client-key ./${USER}/${USER}.key
kubectl config set-context ${USER} --cluster=minikube --user=${USER}
kubectl config use-context ${USER}
