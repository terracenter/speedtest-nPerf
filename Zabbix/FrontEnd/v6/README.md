
* Ejecución del contenedor (Producción)
    ```bash
        docker run --name zabbix-web-nginx-pgsql \
            -e DB_SERVER_HOST="172.16.10.7" -e POSTGRES_USER="noc_valencia"  -e POSTGRES_PASSWORD="noc$val$20$" \
            -e ZBX_SERVER_HOST="172.16.11.14" \
            -e PHP_TZ="America/Caracas" \
            --cpus="4" \
            --memory "4g" \
            --network zabbix \
            --ip 192.168.226.22 \
            -d zabbix/zabbix-web-nginx-pgsql:6.0-ubuntu-latest
        
    ```
