
# one control-plane cluster
```
kind create cluster --name kindname --image kindest/node:v1.19.1
```

# one control-plane 2 worker cluster
```
kind create cluster --name kindname1c2w --config kind-1c2w.yaml
```

# 3 control-plane 3 worker cluster
```
kind create cluster --name kindname3c3w --config kind-3c3w.yaml
```

