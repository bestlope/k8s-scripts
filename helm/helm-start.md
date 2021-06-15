helm search repo ingress

# use online chart
helm install ingress-nginx bitnami/nginx-ingress-controller --namespace kube-system

# use offline chart
helm install [NAME] [CHART] [flags]
helm install myrabbitmq rabbitmq --namespace rabbitmq --values .\rabbitmq\values.yaml