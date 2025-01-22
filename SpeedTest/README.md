


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

    ipv4:     190.103.31.10/30
    Gateway:  190.103.31.9
    mascara:  255.255.255.252
    red:      190.103.31.8/30

    ipv6:     2803:c000:13e:1::12/126
    gateway:  2803:c000:13e:1::11
    red:      2803:c000:13e:1::10/126



DualStack
```
docker network create -d macvlan \
    --subnet=190.103.31.8/30 \
    --gateway=190.103.31.9 \
    --ipv6 --subnet=2803:c000:13e:1::10/126 --gateway=2803:c000:13e:1::11 \
     -o parent=ens3f0 \
     -o macvlan_mode=passthru speedtest
```


Ejeucion con la red dualstack
---

docker run --rm -dit \
        --network speedtest \
        --name speedtest \
        --cpus 8 \
        --memory "8g" \
        -h speedtest-valencia \
        speedtest-ubuntu \
        bash


ejecucion test:
---


docker run --rm -dit \
        --network speedtest \
        --name speedtest \
        --cpus="4"  \
        --memory "8g" \
        -h speedtest-valencia \
        debian:speedtest \
        bash

Ejecuion via bash
./OoklaServer --daemon 

./ooklaserver.sh -f start
