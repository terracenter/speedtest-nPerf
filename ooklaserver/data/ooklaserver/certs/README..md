
Esta es una lista de elementos de Docker Compose versión 2 que pueden afectar al rendimiento y la precisión de OoklaServer.

No se trata de una lista exhaustiva de los elementos de Compose, algunos de los cuales pueden ser útiles y también se muestran en los archivos de ejemplo incorporados en la sección 8.2. Para obtener más información, consulte la documentación de docker-compose de Docker.


8.1.1. **cpus**:
- Número de CPU que puede admitir el contenedor; déjelo sin configurar para consumir hasta
el 100 % de la CPU del host.

8.1.2. **cpuset**:
- Núcleos en los que se puede llevar a cabo la ejecución, ejemplo para hiperprocesamiento de 4 núcleos/8
hilos: ejecutar OoklaServer en los núcleos 1, 3, 5, 7 y todos los demás contenedores en los núcleos 0,
2, 4, 6.

- Debe utilizar cpuset para aislar OoklaServer en un único socket en un sistema multisocket.
Las irq pueden ir a otro núcleo del sistema, donde mover
OoklaServer más cerca del núcleo que gestiona las irq puede aumentar la precisión de las pruebas al
reducir la latencia general por paquete.

8.1.3. **mem_limit**:
- Establecido en un mínimo de 8 GB para 10 Gbps, pero 12 GB permiten más clientes. Más memoria
no perjudica al proceso OoklaServer, que utilizará la que necesite si hay recursos disponibles.

8.1.4. **mem_swap_limit**:
- Establecer la misma cantidad que la memoria para que no se use el intercambio

8.1.5. **mem_reservation**:
- Establezca el mismo valor que memory. Esto evita que otros contenedores y procesos utilicen la memoria que OoklaServer espera poder asignar bajo demanda.

8.1.6. **memoom_kill_disable**:
- Cuando existe un límite de memoria, se debe establecer oom_kill_disable en verdadero para que
el sistema no elimine este contenedor cuando la memoria del sistema se esté agotando.


8.2. Archivos de ejemplo para Docker:

8.2.1. docker-compose.yml

```docker
version: "3.7"
services:
  server:
    build:
    context: .
    dockerfile: Dockerfile
  container_name: OoklaServerHub
  # Utilícelo en servidores donde la memoria libre real sea baja
  # para evitar que el contenedor sea eliminado por oom_killer.
  # Normalmente, no hay problema en tenerlo activado cuando --memory está presente,
  # ya que --memory es la cantidad máxima que el contenedor
  # OoklaServer process, therefore oom_kill_disable: true
  # es seguro de usar aquí.
  oom_kill_disable: true
  
  # 2G para 1Gbps, 8G para 10 o más Gbps, más memoria = más clientes simultáneos.
  # Todos estos deben tener el mismo valor para evitar
  # que la memoria se intercambie o que otros procesos/contenedores
  # puedan utilizar el rango que el contenedor puede asignar.
  # Evitar esas disputas reduce la latencia y permite a OoklaServer
  # ofrecer los resultados más precisos.
  mem_limit: 2g
  memswap_limit: 2g
  mem_reservation: 2g
  
  # El modo host elimina gran parte de la sobrecarga en la entrega de paquetes,
  # a diferencia de lo que ocurre con una red docker normal:
  network_mode: "host"
  
  # El directorio en el que se encuentra el archivo compose también debe
  # contener el binario OoklaServer y un archivo OoklaServer.properties,
  # que se montará como /server dentro del contenedor:

  volumes:
    - .:/server
  # si alguien detiene el contenedor, espera unos segundos para
  # enviar los últimos finacks tcp, pero si no es así, retíralo
  # rápidamente para que la siguiente instancia pueda iniciarse sin
  # esperar los 10 segundos predeterminados:
  stop_grace_period: 3s
  restart: "unless-stopped"
  entrypoint:
    - "/server/OoklaServer"
    - "-d"
  # La comprobación de estado de Docker es «informativa» a menos que se utilice Docker Swarm.
  # La comprobación de estado se puede programar comprobando la salida JSON del
  # comando «docker inspect OoklaServer» en el host de Docker.
  healthcheck:
    test: wget --no-verbose --tries=1 --spider http://localhost:8080 || exit 1
    interval: 5s
    timeout: 5s
    retries: 2
```
