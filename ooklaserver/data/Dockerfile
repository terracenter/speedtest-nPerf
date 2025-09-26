# Ookla's own ooklaserver package:
FROM ookla/ooklaserver:latest

USER root

# update available package lists
RUN apk update

# update CA certs for SSL, install wget for healthchecks
#RUN apt-get install -y ca-certificates wget
RUN apk add ca-certificates wget

USER ooklaserver
WORKDIR /opt/ooklaserver


# Configuración dell las Propiedades de OoklaServer
RUN echo "Proceso de configuración" && \
echo "OoklaServer.useIPv6 = true " >>  OoklaServer.properties && \
echo "OoklaServer.allowedDomains = *.ookla.com, *.speedtest.net" >>  OoklaServer.properties && \
echo "OoklaServer.enableAutoUpdate = true" >>  OoklaServer.properties &&\
echo "OoklaServer.ssl.useLetsEncrypt = true" >>  OoklaServer.properties
