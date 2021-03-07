# use linux envriment
```
docker run -it --rm -v ${HOME}:/root/ -v ${PWD}:/work -w /work --net host alpine sh

apk add --no-cache curl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl
```

# get weavescope.yaml
```
curl -L -O https://cloud.weave.works/launch/k8s/weavescope.yaml
```

# get start in k8s
```
kubectl create -f 'https://cloud.weave.works/launch/k8s/weavescope.yaml' 
```

# exposing weave on public ip  
```
pod=$(kubectl get pod -n weave --selector=name=weave-scope-app -o jsonpath={.items..metadata.name})
kubectl expose pod $pod -n weave --external-ip="192.168.123.193" --port=4040 --target-port=4040
```

