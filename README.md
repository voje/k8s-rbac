# k8s-rbac
Testing different RBAC settings

https://www.adaltas.com/en/2019/08/07/users-rbac-kubernetes/

```bash
minikube start
```

K8s doesn't have a "create users" api.   
We create users (ssl client certs), sign them with the minikube CA.   
This allows us to add users to the context and authenticate against the cluster.   

Add roles as the admin (minikube) user.   
```bash
k config use-context minikube
k apply -f manifests/alice-ns
```

The manifest creates a namespace `alice-ns`.   
It creates two Rolebindings:   
    * bind 'edit' ClusterRole to alice in namespace alice-ns
    * bind 'view' ClusterRole to bob in namespace alice-ns
You can use the default **ClusterRoles** view, edit, admin.   
Just make sure to bind them to a specific namespace by using a **RoleBinding**.   
Using ClusterRoleBindings would give users permissions across the whole cluster.   
We don't want that.   

```bash
k config use-context alice
k run --image=nginx nginx -n alice-ns       # allowed
k get pods -n kube-system                   # super not allowed

k config use-context bob
k delete pod nginx -n alice-ns              # not allowed
k get pods
```


