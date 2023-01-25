ARG ALPINE_VERSION="3.17.0"

FROM gautada/alpine:$ALPINE_VERSION

# ╭――――――――――――――――――――╮
# │ METADATA           │
# ╰――――――――――――――――――――╯
LABEL source="https://github.com/gautada/homebridge-container.git"
LABEL maintainer="Adam Gautier <adam@gautier.org>"
LABEL description="A container for a Homebridge bridge to Apple HomeKit"

# ╭――――――――――――――――――――╮
# │ STANDARD CONFIG    │
# ╰――――――――――――――――――――╯

# USER:
ARG USER=homebridge

ARG UID=1001
ARG GID=1001
RUN /usr/sbin/addgroup -g $GID $USER \
 && /usr/sbin/adduser -D -G $USER -s /bin/ash -u $UID $USER \
 && /usr/sbin/usermod -aG wheel $USER \
 && /bin/echo "$USER:$USER" | chpasswd

# PRIVILEGE:
COPY wheel  /etc/container/wheel

# BACKUP:
COPY backup /etc/container/backup

# VERSION:
COPY version /usr/bin/version

# ENTRYPOINT:
RUN rm -v /etc/container/entrypoint
COPY entrypoint /etc/container/entrypoint

# FOLDERS
RUN /bin/chown -R $USER:$USER /mnt/volumes/container \
 && /bin/chown -R $USER:$USER /mnt/volumes/backup \
 && /bin/chown -R $USER:$USER /var/backup \
 && /bin/chown -R $USER:$USER /tmp/backup

# ╭――――――――――――――――――――╮
# │ APPLICATION        │
# ╰――――――――――――――――――――╯
RUN /sbin/apk add --no-cache jq nodejs npm nmap openssl build-base

ARG HOMEBRIDGE_VERSION=1.6.0
RUN /usr/bin/npm install --global --unsafe-perm --verbose homebridge@$HOMEBRIDGE_VERSION homebridge-config-ui-x
RUN /usr/bin/npm install --global --unsafe-perm --verbose homebridge-ring homebridge-nest homebridge-rainbird homebridge-tplink-smarthome homebridge-broadlink-rm-pro

RUN /bin/ln -fsv /usr/local/lib/node_modules/homebridge/bin/homebridge /usr/sbin/homebridge-bridge

RUN /bin/ln -fsv /usr/local/lib/node_modules/homebridge-config-ui-x/dist/bin/standalone.js /usr/sbin/homebridge-ui

RUN /bin/mkdir -p /home/$USER/.homebridge \
 && chown $USER:$USER -R /home/$USER/.homebridge
 
RUN /bin/ln -fsv /mnt/volumes/configmaps/config.json /home/$USER/.homebridge/config.json \
 && /bin/ln -fsv /mnt/volumes/configmaps/config.json /etc/container/config.json \
 && /bin/ln -fsv /mnt/volumes/container/config.json /mnt/volumes/configmaps/config.json

RUN /bin/ln -fsv /mnt/volumes/configmaps/auth.json /home/$USER/.homebridge/auth.json \
 && /bin/ln -fsv /mnt/volumes/configmaps/auth.json /etc/container/auth.json \
 && /bin/ln -fsv /mnt/volumes/container/auth.json /mnt/volumes/configmaps/auth.json
 
# ╭――――――――――――――――――――╮
# │ CONTAINER          │
# ╰――――――――――――――――――――╯
USER $USER
VOLUME /mnt/volumes/backup
VOLUME /mnt/volumes/configmaps
VOLUME /mnt/volumes/container
EXPOSE 8080/tcp 51400/tcp 5353/udp
WORKDIR /home/$USER


