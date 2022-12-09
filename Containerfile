ARG ALPINE_VERSION=3.16.0

# ╭――――――――――――――――---------------------------------------------------------――╮
# │                                                                           │
# │ STAGE 1: homebridge-container                                             │
# │                                                                           │
# ╰―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――╯
FROM gautada/alpine:$ALPINE_VERSION

# ╭――――――――――――――――――――╮
# │ METADATA           │
# ╰――――――――――――――――――――╯
LABEL version="2022-06-06"
LABEL source="https://github.com/gautada/homebridge-container.git"
LABEL maintainer="Adam Gautier <adam@gautier.org>"
LABEL description="A basic homebridge for homekit integration."

# ╭――――――――――――――――――――╮
# │ USER               │
# ╰――――――――――――――――――――╯
ARG UID=1001
ARG GID=1001
ARG USER=homebridge
RUN /usr/sbin/addgroup -g $GID $USER \
 && /usr/sbin/adduser -D -G $USER -s /bin/ash -u $UID $USER \
 && /usr/sbin/usermod -aG wheel $USER \
 && /bin/echo "$USER:$USER" | chpasswd
 
# ╭――――――――――――――――――――╮
# │ PORTS              │
# ╰――――――――――――――――――――╯
EXPOSE 8080/tcp
EXPOSE 51400/tcp
EXPOSE 5353/udp
# EXPOSE 41000/udp

# ╭――――――――――――――――――――╮
# │ CONFIG             │
# ╰――――――――――――――――――――╯
RUN ln -s /etc/container/configmap.d /etc/homebridge

# ╭――――――――――――――――――――╮
# │ ENTRYPOINT         │
# ╰――――――――――――――――――――╯
RUN rm -v /etc/container/entrypoint
COPY entrypoint /etc/container/entrypoint

# ╭――――――――――――――――――――╮
# │ BACKUP             │
# ╰――――――――――――――――――――╯
COPY backup /etc/container/backup

# ╭――――――――――――――――――――╮
# │ PRIVILEGED         │
# ╰――――――――――――――――――――╯
COPY wheel  /etc/container/wheel

# ╭――――――――――――――――――――╮
# │ APPLICATION        │
# ╰――――――――――――――――――――╯
ARG HOMEBRIDGE_VERSION=1.4.1
# Packages that were remove for minimal install "avahi-compat-libdns_sd avahi-dev dbus"
# Maybe run avahi as a separate container/pod
RUN apk add --no-cache jq nodejs npm nmap openssl build-base
RUN npm install --global --unsafe-perm --verbose homebridge@$HOMEBRIDGE_VERSION homebridge-config-ui-x
RUN npm install --global --unsafe-perm --verbose homebridge-ring homebridge-nest homebridge-rainbird homebridge-tplink-smarthome
# https://broadlink.kiwicam.nz
RUN npm install --global --unsafe-perm --verbose homebridge-broadlink-rm-pro

COPY homebridge-service-generator /usr/bin/homebridge-service-generator
RUN ln -s /usr/local/lib/node_modules/homebridge/bin/homebridge /usr/sbin/homebridge-bridge
RUN ln -s /usr/local/lib/node_modules/homebridge-config-ui-x/dist/bin/standalone.js /usr/sbin/homebridge-ui

RUN /bin/mkdir -p /opt/$USER
RUN /bin/chown -R $USER:$USER /opt/$USER /var/backup /tmp/backup /mnt/volumes/backup

USER $USER
WORKDIR /home/$USER

