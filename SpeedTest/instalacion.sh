#!/bin/bash


# Proceso de instalación
echo "Proceso de instalación"
./ooklaserver.sh install

# Proceso de configuración
echo "Proceso de configuración"

echo "OoklaServer.useIPv6 = true " >>  OoklaServer.properties && \
echo "OoklaServer.allowedDomains = *.ookla.com, *.speedtest.net" >>  OoklaServer.properties && \
echo "OoklaServer.enableAutoUpdate = true" >>  OoklaServer.properties &&\
echo "OoklaServer.ssl.useLetsEncrypt = true" >>  OoklaServer.properties

# Proceso de incio
echo  "Iniciando"
./ooklaserver.sh restart