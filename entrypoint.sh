
if [ -d /certificates ] && [ -f /certificates/*.pem ]
then
    c=0
    for CERT in $(ls /certificates/*.pem)
    do
        c=$(( $c + 1 ))
        keytool -noprompt -trustcacerts -cacerts -storepass changeit -import -alias auto-add-$c -file $CERT
    done
else
    echo "No certificate files found in directory"
fi