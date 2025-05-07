# Instalación de Zabbix Server sobre Docker
* PostgreSQL
* Zabbix Server
* Zabbix Web
* Zabbix Proxy


## Zabbix Proxy 

- HOST
    * Creación partción de Trabajo
        ```bash
        sudo lvcreate -L+4G -n zabbix_v7 vg0
        ```
        ```bash
        sudo mkfs.ext4 /dev/vg0/zabbix_v7
        ```
        ```bash
        sudo mkdir /srv/zabbix_v7
        ```
        ```bash
        sudo mount /dev/vg0/zabbix_v7 /srv/zabbix_v7
        ```
        ```bash
        sudo chmod -R 777 /srv/zabbix_v7/db_data
        ```
    * RED
        ```
        Address:   192.168.226.16        11000000.10101000.11100010.0001 0000
        Netmask:   255.255.255.240 = 28  11111111.11111111.11111111.1111 0000
        Wildcard:  0.0.0.15              00000000.00000000.00000000.0000 1111
        =>
        Network:   192.168.226.16/28     11000000.10101000.11100010.0001 0000 (Class C)
        Broadcast: 192.168.226.31        11000000.10101000.11100010.0001 1111
        HostMin:   192.168.226.17        11000000.10101000.11100010.0001 0001
        HostMax:   192.168.226.30        11000000.10101000.11100010.0001 1110
        Hosts/Net: 14                    (Private Internet)
        ```
    * Red del Host
        ```bash
        IP: 192.168.226.19/28
        GW: 192.168.226.17
        ```

## Contenedor
* Red - misma red del Host, pero usando el driver `macvlan` 
    ```bash
    docker network create -d macvlan \
    --subnet=192.168.226.16/28 \
    --gateway=192.168.226.17 \
    -o parent=eno1 \
    zabbix
    ```

* Generar el PSK
    ```bash
    openssl rand -hex 32 | sudo tee /srv/zabbix_v7/enc/proxy_secret.psk
    ```
    ```bash
    sudo chmod 640 /srv/zabbix_v7/enc/proxy_secret.psk
    ```
    ```bash
    sudo chown -R zabbix:zabbix /etc/zabbix/proxy_secret.psk 
    ```


* Ejecución del contenedor (Producción)
```bash

docker run \
    --restart=always \
    --name zabbix-proxy-sqlite3-v7 \
    -h zabbix-proxy-carabobo-valencia-docker \
    -e ZBX_ENABLEREMOTECOMMANDS=1 \
    -e ZBX_LOGREMOTECOMMANDS=1 \
    -e ZBX_PROXYLOCALBUFFER=0 \
    -e ZBX_PROXYOFFLINEBUFFER=1 \
    -e ZBX_DATASENDERFREQUENCY=1 \
    -e ZBX_STARTPOLLERS=180 \
    -e ZBX_STARTPREPROCESSORS=3 \
    -e ZBX_STARTPOLLERSUNREACHABLE=10 \
    -e ZBX_STARTPINGERS=6 \
    -e ZBX_CACHESIZE=256M \
    -e ZBX_STARTDBSYNCERS=4 \
    -e ZBX_HISTORYCACHESIZE=18M \
    -e ZBX_HISTORYINDEXCACHESIZE=4M \
    -e ZBX_HOSTNAME=zb-proxy-carabobo-valencia-docker \
    -e ZBX_SERVER_HOST=172.16.11.24 \
    -v /srv/zabbix_v7/externalscripts:/usr/lib/zabbix/externalscripts \
    -v /srv/zabbix_v7/db_data:/var/lib/zabbix/db_dada \
    -v /srv/zabbix_v7/modules:/var/lib/zabbix/modules \
    -v /srv/zabbix_v7/enc:/var/lib/zabbix/enc \
    -v /srv/zabbix_v7/ssh_keys:/var/lib/zabbix/ssh_keys  \
    -v /srv/zabbix_v7/snmptraps:/var/lib/zabbix/snmptraps \
    -v /srv/zabbix_v7/mibs:/var/lib/zabbix/mibs \
    --cpus="4" \
    --memory "4g" \
    --network zabbix \
    --ip 192.168.226.21 \
    -d zabbix/zabbix-proxy-sqlite3:7.0-ubuntu-latest

```


sudo zabbix_proxy -R config_cache_reload && sudo zabbix_proxy -R housekeeper_execute  && sudo zabbix_proxy -R snmp_cache_reload 


zabbix_proxy -R config_cache_reload && zabbix_proxy -R housekeeper_execute  && zabbix_proxy -R snmp_cache_reload 





* Claves precompartidas de encrptación del Zabbix Proxy
```bash

docker run --name zabbix-proxy-sqlite3-v7 \
    -h zabbix-proxy-carabobo-valencia-docker \
    -e ZBX_ENABLEREMOTECOMMANDS=1 \
    -e ZBX_LOGREMOTECOMMANDS=1 \
    -e ZBX_HOSTNAMEITEM=system.hostname \
    -e ZBX_PROXYLOCALBUFFER=0 \
    -e ZBX_PROXYOFFLINEBUFFER=1 \
    -e ZBX_DATASENDERFREQUENCY=1 \
    -e ZBX_STARTPOLLERS=40 \
    -e ZBX_STARTPREPROCESSORS=3 \
    -e ZBX_STARTPOLLERSUNREACHABLE=10 \
    -e ZBX_STARTPINGERS=6 \
    -e ZBX_CACHESIZE=64M \
    -e ZBX_STARTDBSYNCERS=4 \
    -e ZBX_HISTORYCACHESIZE=16M \
    -e ZBX_HISTORYINDEXCACHESIZE=4M \
    -e ZBX_HOSTNAME=zb-proxy-valencia-docker \
    -e ZBX_SERVER_HOST=172.16.11.14 \
    -v /srv/zabbix_v7/externalscripts:/usr/lib/zabbix/externalscripts \
    -v /srv/zabbix_v7/db_data:/var/lib/zabbix/db_dada \
    -v /srv/zabbix_v7/modules:/var/lib/zabbix/modules \
    -v /srv/zabbix_v7/enc:/var/lib/zabbix/enc_internal \
    -v /srv/zabbix_v7/ssh_keys:/var/lib/zabbix/ssh_keys  \
    -v /srv/zabbix_v7/snmptraps:/var/lib/zabbix/snmptraps \
    -v /srv/zabbix_v7/mibs:/var/lib/zabbix/mibs \
    -e ZBX_TLSPSKIDENTITY=zabbix-proxy-carabobo-valencia-docker-psk \
    -e ZBX_TLSPSKFILE=proxy_secret.psk \
    -e ZBX_TLSPSK=psk \
    -e ZBX_TLSCONNECT=psk \
    --cpus="4" --memory "4g"  --network zabbix  --ip 192.168.226.20 \
    -d zabbix/zabbix-proxy-sqlite3:6.0-ubuntu-latest 
    
```
