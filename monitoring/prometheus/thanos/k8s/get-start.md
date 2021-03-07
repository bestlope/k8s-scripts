https://github.com/thanos-io/kube-thanos

# git clone
```
git clone https://github.com/thanos-io/kube-thanos.git

```

# deploy on k8s
```
kubectl create ns thanos
kubectl apply -f kube-thanos/manifests/
```