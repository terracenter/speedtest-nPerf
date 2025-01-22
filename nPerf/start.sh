#!/bin/bash
# Inicia el servicio nperf-server
/etc/init.d/nperf-server start

# Verifica si el servicio está en ejecución
if ! pgrep -f "nperf-server" > /dev/null; then
    echo "Error: nperf-server no se está ejecutando."
    exit 1
fi

# Mantén el contenedor en ejecución
tail -f /dev/null