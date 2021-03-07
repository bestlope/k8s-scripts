# Deploy KubeVirt
```
export KUBEVIRT_VERSION=$(curl -s https://api.github.com/repos/kubevirt/kubevirt/releases/latest | jq -r .tag_name)
echo $KUBEVIRT_VERSION

kubectl create -f https://github.com/kubevirt/kubevirt/releases/download/${KUBEVIRT_VERSION}/kubevirt-operator.yaml

kubectl create configmap kubevirt-config -n kubevirt --from-literal debug.useEmulation=true

kubectl create -f https://github.com/kubevirt/kubevirt/releases/download/${KUBEVIRT_VERSION}/kubevirt-cr.yaml

```

## Install Virtctl
```
wget -O virtctl https://github.com/kubevirt/kubevirt/releases/download/${KUBEVIRT_VERSION}/virtctl-${KUBEVIRT_VERSION}-linux-amd64

chmod +x virtctl 

mv virtctl /usr/local/bin/virtctl

```

# Install the CDI 
```
### edit stoargeclass=standard <what your cluster storageclass>
wget https://raw.githubusercontent.com/kubevirt/kubevirt.github.io/master/labs/manifests/storage-setup.yml

kubectl create -f storage-setup.yml

export VERSION=$(curl -s https://github.com/kubevirt/containerized-data-importer/releases/latest | grep -o "v[0-9]\.[0-9]*\.[0-9]*")

kubectl create -f https://github.com/kubevirt/containerized-data-importer/releases/download/$VERSION/cdi-operator.yaml

kubectl create -f https://github.com/kubevirt/containerized-data-importer/releases/download/$VERSION/cdi-cr.yaml

kubectl get pods -n cdi

```
## use cdi
```
kubectl create -f https://raw.githubusercontent.com/kubevirt/kubevirt.github.io/master/labs/manifests/pvc_fedora.yml

kubectl logs -f $(kubectl get pods -o name)

wget https://raw.githubusercontent.com/kubevirt/kubevirt.github.io/master/labs/manifests/vm1_pvc.yml

```
## Prepare SSH passwordless login
```
rm -fv ~/.ssh/id_rsa
ssh-keygen -N '' -f ~/.ssh/id_rsa
PUBKEY=$(cat ~/.ssh/id_rsa.pub)
sed -i "s%ssh-rsa.*%$PUBKEY%" vm1_pvc.yml
```
## create vm
```
kubectl create -f vm1_pvc.yml

kubectl get pod -o wide
```

## login vm
```
ssh fedora@10.32.0.11
```

