# if you need linux envriment 
```
docker run -it --rm -v ${HOME}:/root/ -v ${PWD}:/work -w /work --net host alpine sh

apk add --no-cache curl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl
```

# start with 'https://kind.sigs.k8s.io/docs/user/loadbalancer/'

Installing metallb using default manifests
Create the metallb namespace
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/master/manifests/namespace.yaml
COPY
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/master/manifests/namespace.yaml
Create the memberlist secrets
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" 
COPY
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)" 
Apply metallb manifest
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/master/manifests/metallb.yaml
COPY
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/master/manifests/metallb.yaml
Wait for metallb pods to have a status of Running

kubectl get pods -n metallb-system --watch
COPY
kubectl get pods -n metallb-system --watch
Setup address pool used by loadbalancers
To complete layer2 configuration, we need to provide metallb a range of IP addresses it controls. We want this range to be on the docker kind network.

docker network inspect -f '{{.IPAM.Config}}' kind
COPY
docker network inspect -f '{{.IPAM.Config}}' kind
The output will contain a cidr such as 172.19.0.0/16. We want our loadbalancer IP range to come from this subclass. We can configure metallb, for instance, to use 172.19.255.200 to 172.19.255.250 by creating the configmap.

apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - 172.19.255.200-172.19.255.250
Apply the contents

kubectl apply -f https://kind.sigs.k8s.io/examples/loadbalancer/metallb-configmap.yaml
COPY
kubectl apply -f https://kind.sigs.k8s.io/examples/loadbalancer/metallb-configmap.yaml
Using LoadBalancer
The following example creates a loadbalancer service that routes to two http-echo pods, one that outputs foo and the other outputs bar.

kind: Pod
apiVersion: v1
metadata:
  name: foo-app
  labels:
    app: http-echo
spec:
  containers:
  - name: foo-app
    image: hashicorp/http-echo:0.2.3
    args:
    - "-text=foo"
---
kind: Pod
apiVersion: v1
metadata:
  name: bar-app
  labels:
    app: http-echo
spec:
  containers:
  - name: bar-app
    image: hashicorp/http-echo:0.2.3
    args:
    - "-text=bar"
---
kind: Service
apiVersion: v1
metadata:
  name: foo-service
spec:
  type: LoadBalancer
  selector:
    app: http-echo
  ports:
  # Default port used by the image
  - port: 5678

Apply the contents

kubectl apply -f https://kind.sigs.k8s.io/examples/loadbalancer/usage.yaml
COPY
kubectl apply -f https://kind.sigs.k8s.io/examples/loadbalancer/usage.yaml
Now verify that the loadbalancer works by sending traffic to it's external IP and port.

LB_IP=$(kubectl get svc/foo-service -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')
COPY
LB_IP=$(kubectl get svc/foo-service -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')
# should output foo and bar on separate lines 
for _ in {1..10}; do
  curl ${LB_IP}:5678
done