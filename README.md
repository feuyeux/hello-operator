# Hello Operator
- [kubebuilder-sample](kubebuilder-sample)
- [operator-sdk-sample](operator-sdk-sample)

> [Kubebuilder](https://github.com/kubernetes-sigs/kubebuilder) and [Operator SDK](https://github.com/operator-framework/operator-sdk) have long been seen as competitors in the field of Operator tooling, when in reality there was collaboration going on for some time already. 
> Now, with the Operator Framework being incubated into CNCF, we are coming together on a single solution that creates Golang Operators (Kubebuilder) while the SDK provides a holistic experience in creating, testing, bundling and releasing Operators.
> https://www.openshift.com/blog/operator-sdk-reaches-v1.0

## Guestbook Sample
### 1 init
```sh
sh build_sample.sh
sh open_sample.sh
```

### 2 edit
1. api/v1/guestbook_types.go:32
   ```go
   BookName string `json:"book_name,omitempty"`
   ```
1. api/v1/guestbook_types.go:38
   ```go
   Status string `json:"Status"`
   ```
1. controllers/guestbook_controller.go:45
   ```go
   obj := &appv1.Guestbook{}
   if err := r.Get(ctx, req.NamespacedName, obj); err != nil {
     log.Println(err, "Unable to fetch object")
   } else {
     log.Println("Greeting from Kubebuilder to", obj.Spec.BookName)
   }
   obj.Status.Status = "Running"
   if err := r.Status().Update(ctx, obj); err != nil {
     log.Println(err, "unable to update status")
   }
   ```
1. config/samples/app_v1_guestbook.yaml
   ```yaml
   apiVersion: app.feuyeux.io/v1
   kind: Guestbook
   metadata:
     name: guestbook-sample
   spec:
     book_name: kubebuilder-operator-sample
   ```
### 3 rebuild&run
```sh
sh rebuild_sample.sh
```

```sh
sh test_sample.sh
```

### 4 cleanup
```sh
echo "Uninstall CRDs"
make uninstall
```
