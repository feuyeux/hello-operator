#!/usr/bin/env sh
rm -rf $GOPATH/src/feuyeux.io/kubebuilder-sample
mkdir -p $GOPATH/src/feuyeux.io/kubebuilder-sample
cd $GOPATH/src/feuyeux.io/kubebuilder-sample
export GOPROXY=https://mirrors.aliyun.com/goproxy/

echo "kubebuilder version:"
kubebuilder version
echo "kustomize version:"
kustomize version
echo

echo "Create a Project"
kubebuilder init --domain feuyeux.io

echo "Create an API"
kubebuilder create api --group app --version v1 --kind Guestbook

echo "Install CRDs"
make install

echo "Install Controller locally"
make run

# echo "Install Controller"
# make docker-build docker-push IMG=feuyeux/kubebuilder-example:latest
# make deploy IMG=feuyeux/kubebuilder-example:latest

echo "Install Instances of Custom Resources"
kubectl apply -f config/samples/

echo ""
kubectl get guestbooks.app.feuyeux.io
kubectl get guestbooks.app.feuyeux.io guestbook-sample -o yaml