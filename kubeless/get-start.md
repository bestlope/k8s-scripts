# install kubeless on k8s server
```
kubectl create ns kubeless
kubectl create -f https://github.com/kubeless/kubeless/releases/download/v1.0.0-alpha.8/kubeless-v1.0.0-alpha.8.yaml
```

# install kubeless on linux client
```
wget https://github.com/kubeless/kubeless/releases/download/v1.0.8/kubeless_linux-amd64.zip
unzip kubeless_linux-amd64.zip && mv ./bundles/kubeless /usr/local/bin/kubeless
chmod +x /usr/local/bin/kubeless
```

# for example: create a pyton function
```
kubeless function deploy toy --runtime python2.7 \
                              --handler toy.handler \
                              --from-file applications/toy.py
```
## cheack function
```
kubeless function ls
kubeless function logs toy
kubeless function describe toy 
```
## we can update out application
```
kubeless function update toy --from-file applications/toy-update.py
```
```
kubeless function call toy --data '{"hello":"world"}'
```

