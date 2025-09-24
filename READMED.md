# Configuracion Docker
* [Instalación en Debian](https://docs.docker.com/engine/install/debian/)

    ```bash
    # Añade la clave GPG oficial de Docker::
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Añade el repositorio a Apt sources::
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    ```

* Instale los paquetes estables Docker
    ```bash
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    ```


* Desactivar la red por default
    ```bash
     sudo mkdir -p /etc/docker
    ```
    ```bash
    sudo vim /etc/docker/daemon.json
    ```
    ```
    {
         "bip":"198.168.2.1/28"
    }
    ```
    ```bash
    sudo systemctl restart docker
    ```
    ```
    sudo docker network ls
    NETWORK ID     NAME      DRIVER    SCOPE
    5e45d8a71a8e   host      host      local
    2aafd9dc5991   none      null      local
    ```

## Speddtest
* Creación de la red
* Creación del docker-compose
* Ejeución del Docker compose