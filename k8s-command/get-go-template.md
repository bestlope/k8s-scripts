## get ip
```
kubectl get services -l app=examplehttpapp -o go-template='{{(index .items 0).spec.clusterIP}}'
```

## get logs
```
kubectl logs $(kubectl get pods -l app=examplehttpapp -o go-template='{{(index .items 0).metadata.name}}')
```

## get pvc name
VOLS=`kubectl get pvc | grep cassandra | awk '{print $3}'`

## get pod name
PX_POD=$(kubectl get pods -l name=portworx -n kube-system -o jsonpath='{.items[0].metadata.name}')

## get node locate
NODE=`kubectl get pods -o wide | grep cassandra-0 | awk '{print $7}'`
kubectl cordon ${NODE}

## Repalace text
sed -i 's/10Gi/20Gi/g' px-mongo-pvc.yaml

## create secret
kubectl -n portworx create secret generic volume-secrets \
  --from-literal=secure-pvc=SuperSecur3Key

