#!/bin/bash
# Inicia el servicio nperf-server
/usr/bin/nPerfServer --uuidfile /var/lib/nperf-server/nPerfServer.uuid --basedir /etc/nperf/nperf-server.conf --pidfile /var/lib/nperf-server/nPerfServer.pid -p 80 -t 443 -i :: -x

# Verifica si el servicio está en ejecución
if ! pgrep -f "nperf-server" > /dev/null; then
    echo "Error: nperf-server no se está ejecutando."
    exit 1
fi

# Mantén el contenedor en ejecución
tail -f /dev/null