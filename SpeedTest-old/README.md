## Creación de la red
* Informacion de red

    SUBNET-IPV4=190.103.31.8/30 \
    GATEWAY-IPV4=190.103.31.9 \
    SUBNET-IPV6=2803:c000:13e:1::10/126 \ 
    GATEWAY-IPV6=2803:C000:13E:1::11

- DualStack
```
sudo docker network create -d macvlan --subnet=190.103.31.8/30  --gateway=190.103.31.9 --ipv6 --subnet=2803:c000:13e:1::10/126 --gateway=2803:C000:13E:1::11 -o parent=vmbr1 -o macvlan_mode=passthru speedtest
```


Dokcer run
---
docker run --rm -dit --network speedtest --name speedtest 
        --cpus="4"  \
        --memory "8g" \
        -h speedtest-valencia \
        debian:speedtest \
        bash

Ejecuion via bash
./OoklaServer --daemon 

./ooklaserver.sh -f start
