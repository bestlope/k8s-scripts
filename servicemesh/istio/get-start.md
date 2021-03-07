# use docker create a liunx envriment
```
docker run -it --rm -v ${HOME}:/root/ -v ${PWD}:/work -w /work --net host alpine sh
```

## install curl & kubectl & git
```
apk add --no-cache curl git 
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl
```

## Install istio cli
```
curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.9.0 TARGET_ARCH=x86_64 sh -

mv istio-1.9.0/bin/istioctl /usr/local/bin/
chmod +x /usr/local/bin/istioctl
mv istio-1.9.0 /tmp/

```

## istio-tutorial for demo
```
git clone https://github.com/redhat-developer-demos/istio-tutorial
```

## Pre flight checks
```
istioctl x precheck
```

## Istio Profiles

https://istio.io/latest/docs/setup/additional-setup/config-profiles/

```
istioctl profile list

istioctl install --set profile=default

kubectl -n istio-system get pods

istioctl proxy-status

```

## checkout virtualservice yaml
```
istioctl get virtualserivce

istioctl get virtualservice <virtualservice-name> -o yaml -n <namespace>
```

--------------------------------------------------------------------------------------------------
# use demo

# inject sidecar
```
kubectl label ns default istio-injection=enabled

kubectl get namespace -L istio-injection

```


