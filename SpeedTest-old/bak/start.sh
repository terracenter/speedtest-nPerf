#!/bin/bash


# Inicia el servicio nperf-server
./home/ooklauser/OoklaServer --daemon 

# Verifica si el servicio está en ejecución
if ! pgrep -f "OoklaServer" > /dev/null; then
    echo "Error: SpeedTest no se está ejecutando."
    exit 1
fi

# Mantén el contenedor en ejecución
tail -f /dev/null
