#!/usr/bin/env sh
rm -rf $GOPATH/src/feuyeux.io/operator-sdk-sample
mkdir -p $GOPATH/src/feuyeux.io/operator-sdk-sample
cd $GOPATH/src/feuyeux.io/operator-sdk-sample
export GOPROXY=https://mirrors.aliyun.com/goproxy/

echo "operator-sdk version:"
operator-sdk version

operator-sdk init --domain=feuyeux.io --repo=github.com/feuyeux/operator-sdk-sample
operator-sdk create api --group app --version v1 --kind Guestbook --resource=true --controller=true

echo "Install CRDs"
make install

echo "Install Controller locally"
make run

# echo "Install Controller"
# make docker-build docker-push IMG=feuyeux/kubebuilder-example:latest
# make deploy IMG=feuyeux/kubebuilder-example:latest

echo "Install Instances of Custom Resources"
cd $GOPATH/src/feuyeux.io/operator-sdk-sample
kubectl apply -f config/samples/app_v1_guestbook.yaml

kubectl get guestbooks guestbook-sample -o yaml