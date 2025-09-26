# Ookla's own ooklaserver package:
FROM ookla/ooklaserver:latest

USER root
# update available package lists
RUN apk update

# update CA certs for SSL, install wget for healthchecks
#RUN apt-get install -y ca-certificates wget
RUN apk add ca-certificates wget