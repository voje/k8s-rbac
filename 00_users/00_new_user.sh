#!/bin/bash

USER="$1"

if [ -z $USER ]; then
    echo "new_user <user>"
    exit 0
fi

if [ -d $UESR ]; then
    echo "User already exists"
fi
mkdir $USER

pushd $USER

openssl genrsa -out ${USER}.key 2048

openssl req -new -nodes -key ${USER}.key -out ${USER}.csr -subj "/CN=${USER}"

openssl x509 -req -in ${USER}.csr \
  -CA ~/.minikube/ca.crt \
  -CAkey ~/.minikube/ca.key \
  -CAcreateserial \
  -out ${USER}.crt -days 500

popd
