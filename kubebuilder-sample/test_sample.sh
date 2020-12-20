#!/usr/bin/env sh
cd $GOPATH/src/feuyeux.io/kubebuilder-sample
kubectl apply -f config/samples/app_v1_guestbook.yaml
kubectl get guestbooks.app.feuyeux.io
kubectl get guestbooks.app.feuyeux.io guestbook-sample -o yaml
kubectl delete guestbooks.app.feuyeux.io guestbook-sample