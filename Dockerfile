ARG IMG=openjdk:11-jre-slim
FROM ${IMG}

WORKDIR /
ADD entrypoint.sh /

ENTRYPOINT ["/bin/bash","/entrypoint.sh"]
