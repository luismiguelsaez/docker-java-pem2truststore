
## Preparation
### Generate test certificate
```
openssl req -x509 -newkey rsa:4096 -keyout certificates/key.pem -out certificates/cert.pem -days 365 -nodes -subj '/CN=localhost'
```

## Image build
### Build
```
docker build -t luismiguelsaez/pem2truststore .
```
### Push
```
docker push luismiguelsaez/pem2truststore
```

## Kubernetes testing
### Create certificates configmap ( optional, as it's included in the manifest )
```
kubectl create configmap cert-files --from-file=certificates/
```
### Apply manifests
```
kubectl apply -f k8s
```
### Check logs
```
kubectl logs -f pods/test-certs -c init-java-cacerts
```
