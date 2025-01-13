# Fleet Nperf 
## Contenido
- Docker
   - Debian
        - Imagen
            - Build
- Creación de la red

    - Ejecución



### Creación de la red
- Paquete requerido 
    - Debian
    ```bash
    apt install bridge-utils
    ```
- Red IPv4
    ```
    docker network create -d macvlan \
    --subnet=190.103.31.188/30 \
    --gateway=190.103.31.189 \
    -o parent=ens3f0 fleet-ipv4-net
    ```

    ipv4:     190.103.31.190/30
    Gateway:  190.103.31.189 
    mascara:  255.255.255.252
    red:      190.103.31.188/30



Pero mejor dualStack

```
docker network create -d macvlan \
    --subnet=190.103.31.188/30 \
    --gateway=190.103.31.189 \
    --subnet=2803:C000:13E:1::284/126 --gateway=2803:C000:13E:1::285 \
     -o parent=ens3f0 \
     -o macvlan_mode=bridge fleet-dual-net
```
ipv6:     2803:C000:13E:1::286/126
gateway:  2803:C000:13E:1::285
red:      2803:C000:13E:1::284/126


Ejeucion con la red dualstack

docker run --rm -dit \
        --network fleet-dual-net \
        --name fleet \
        --cpus 8 \
        --memory "8g" \
        -h fleet-valencia \
        debian:fleet-v2 \
        bash