#!/usr/bin/env sh
cd $GOPATH/src/feuyeux.io/kubebuilder-sample
export GOPROXY=https://mirrors.aliyun.com/goproxy/
echo "Install CRDs"
make install
echo "Install Controller locally"
make run