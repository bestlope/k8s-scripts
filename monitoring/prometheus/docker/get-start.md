# use docker create prometheus
```
docker run -d --net=host \
    -v /root/prometheus.yml:/etc/prometheus/prometheus.yml \
    --name prometheus-server \
    prom/prometheus

```

# luanch the node exporter
```
docker run -d \
  -v "/proc:/host/proc" \
  -v "/sys:/host/sys" \
  -v "/:/rootfs" \
  --net="host" \
  --name=prometheus \
  quay.io/prometheus/node-exporter:v0.13.0 \
    -collector.procfs /host/proc \
    -collector.sysfs /host/sys \
    -collector.filesystem.ignored-mount-points "^/(sys|proc|dev|host|etc)($|/)"
```
# test mertics
```
curl localhost:9100/metrics
```

or

# 
```
for i in $(seq 0 2); do
docker run -d --net=host --rm \
    -v $(pwd)/prometheus"${i}".yml:/etc/prometheus/prometheus.yml \
    -v $(pwd)/prometheus_data:/prometheus"${i}" \
    -u root \
    --name prometheus"${i}" \
    quay.io/prometheus/prometheus:v2.22.2 \
    --config.file=/etc/prometheus/prometheus.yml \
    --storage.tsdb.path=/prometheus \
    --web.listen-address=:909"${i}" \
    --web.external-url=https://2886795297-909"${i}"-kitek05.environments.katacoda.com \
    --web.enable-lifecycle \
    --web.enable-admin-api && echo "Prometheus ${i} started!"
done

```
