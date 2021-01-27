openssl pkcs12 -export -inkey $keyfile -in $crtfile -out $keystore.pkcs12 -password pass:$password
keytool -importkeystore -noprompt -srckeystore $keystore.pkcs12 -srcstoretype pkcs12 -destkeystore $keystore.jks -storepass $password -srcstorepass $password

keytool -list -v  -keystore $JAVA_HOME/lib/security/cacerts -storepass changeit


### Generate test certificate
```
openssl req -x509 -newkey rsa:4096 -keyout certificates/key.pem -out certificates/cert.pem -days 365 -nodes -subj '/CN=localhost'
```

### Run testing jre
```
docker run --rm -it -v $PWD/certificates:/certificates:ro openjdk:11-jre-slim sh
```

### Create certificates configmap
```
kubectl create configmap cert-files --from-file=certificates/
```

```
cat <<EOF >./kustomization.yaml
configMapGenerator:
- name: cert-files
  files:
  - certificates/cert.pem
  - certificates/cert2.pem
EOF
```# docker-java-pem2truststore
