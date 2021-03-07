# use kind build a k8s cluster
```
kind create cluster --name sonarqube --image kindest/node:v1.19.1
```

# checkout our k8s cluster
```
kubectl version --short && \
kubectl get componentstatus && \
kubectl get nodes && \
kubectl cluster-info
```

# use helm install sonarqube
```
kubectl create ns sonarqube

helm repo add oteemocharts https://oteemo.github.io/charts

```
```
helm install sonar oteemocharts/sonarqube \
  --version 9.2.4 \
  --namespace sonarqube \
  --values sonarqube-values.yaml
```
or
```
helm install sonar oteemocharts/sonarqube --version 9.2.4 --namespace sonarqube --values sonarqube-values.yaml
```

# To get a complete status of the deployment availability run this inspection:
```
watch kubectl get deployments,pods,services --namespace sonarqube
```

# Sonarqube Dashboard
```
kubectl patch service sonar-sonarqube -n sonarqube --type='json' --patch='[{"op": "replace", "path": "/spec/ports/0/nodePort", "value":31111}]'
```
or
```
POD=$(kubectl get pod -n sonarqube --selector=app=sonarqube -o jsonpath={.items..metadata.name})
kubectl expose pod $POD -n sonarqube --external-ip="192.168.123.47" --port=9000 --target-port=9000
```
or
```
kubectl port-forward -n sonarqube svc/sonar-sonarqube 9000
```

# Analyze Project with sonarqube
```
git clone https://github.com/javajon/code-analysis

cd code-analysis/microservice

SONAR_SERVICE=https://2886795293-31111-jago01.environments.katacoda.com

```

# run the analyze
```
./gradlew -Dsonar.host.url=$SONAR_SERVICE sonarqube
```

