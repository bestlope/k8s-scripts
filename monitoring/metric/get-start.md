# install metric-server
```
kubectl -n kube-system apply -f .\metricserver-0.3.7.yaml
```
or

```
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.4.2/components.yaml
```
