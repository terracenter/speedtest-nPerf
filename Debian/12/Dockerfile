FROM debian:bookworm

# # Crear el archivo debian.sources con los repositorios necesarios
RUN sed -i 's/Components: main/Components: main contrib non-free non-free-firmware/' /etc/apt/sources.list.d/debian.sources

# DNS
COPY my_resolv.conf /etc/resolv.conf

# # Actualizar la lista de paquetes
RUN apt update && apt upgrade -y 

# # Instalar paquetes necesarios
RUN apt install -y fontconfig wget libfuse2 libdrm2 vlc && \
    ln -s /usr/lib/x86_64-linux-gnu/vlc /usr/lib/vlc

# Paquetes para fuse
RUN apt install -y squashfuse fuse3
RUN groupadd fuse

ARG USERNAME=fleet
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd -f --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -mG users,fuse $USERNAME

# Herramientas dignostico de red
RUN apt install -y iputils-ping \
    bind9-dnsutils \
    netcat-openbsd \
    iproute2 \
    traceroute

# Concede permisos FUSE dentro del contenedor
RUN echo "$USERNAME:$USERNAME" >> /etc/fuse_lowuser

USER $USERNAME
WORKDIR /home/fleet

RUN echo export PATH=/sbin:$PATH >> ~/.bashrc && \
    echo export APPIMAGE_EXTRACT_AND_RUN=1 >> ~/.bashrc && \
    wget -O nPerf-Fleet-CLI.AppImage https://app.nperf.com/appimageFleetCLILatest?arch=x86_64 && \
    chmod +x nPerf-Fleet-CLI.AppImage


# # Comando a ejecutar al iniciar el contenedor
# CMD ["/home/fleet/nPerf-Fleet-CLI.AppImage", "-h"]