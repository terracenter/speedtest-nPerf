
* Ejecución del contenedor (Producción)
    ```bash
    docker run --name some-zabbix-web-nginx-pgsql \
        -e DB_SERVER_HOST="some-postgres-server"  \
        -v ./.POSTGRES_USER:/run/secrets/POSTGRES_USER  \
        -e POSTGRES_USER_FILE=/run/secrets/POSTGRES_USER  \
        -v ./.POSTGRES_PASSWORD:/run/secrets/POSTGRES_PASSWORD \
        -e POSTGRES_PASSWORD_FILE=/var/run/secrets/POSTGRES_PASSWORD \
        -e ZBX_SERVER_HOST="some-zabbix-server" -e PHP_TZ="some-timezone" \
        --cpus="4" \
        --memory "4g" \
        --network zabbix \
        --ip 192.168.226.22 \ 
        -d zabbix/zabbix-web-nginx-pgsql:7.0-ubuntu-latest
    ```
