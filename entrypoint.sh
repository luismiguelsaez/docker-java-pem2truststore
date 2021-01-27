#!/bin/bash

CERTS_DIR=${CERTS_DIR:-"/certificates"}
STORE_DIR=${STORE_DIR:-"/keystore"}
STORE_NAME=${STORE_NAME:-"keystore.jks"}
STORE_PASS=${STORE_PASS:-"changeit"}
CACERTS=1

if [ $CACERTS -eq 0 ]
then
    PARAMS="-keystore ${STORE_DIR}/${STORE_NAME}"
else
    PARAMS="-trustcacerts -cacerts"
fi
 
if [ -d ${CERTS_DIR} ] && [ $(ls ${CERTS_DIR}/*.pem 2>/dev/nul | wc -l ) -gt 0 ]
then
    c=0
    for CERT in $(ls ${CERTS_DIR}/*.pem)
    do
        c=$(( $c + 1 ))
        keytool -noprompt ${PARAMS} -storepass ${STORE_PASS:-changeit} -import -alias auto-add-$c -file $CERT
    done
else
    echo "No certificate files found in directory ${CERTS_DIR}"
fi
