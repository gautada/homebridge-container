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
# │ SUDO               │
# ╰――――――――――――――――――――╯
COPY wheel-avahi /etc/sudoers.d/wheel-avahi
COPY wheel-dbus /etc/sudoers.d/wheel-dbus
COPY wheel-nmap /etc/sudoers.d/wheel-nmap
COPY wheel-homebridge-service /etc/sudoers.d/wheel-homebridge-service

# ╭――――――――――――――――――――╮
# │ APPLICATION        │
# ╰――――――――――――――――――――╯
ARG HOMEBRIDGE_VERSION=1.4.1
# Packages that were remove for minimal install "avahi-compat-libdns_sd avahi-dev dbus"
# Maybe run avahi as a separate container/pod
RUN apk add --no-cache nodejs npm nmap python3 build-base
RUN npm install -g --unsafe-perm --verbose homebridge@$HOMEBRIDGE_VERSION homebridge-config-ui-x
RUN npm install -g --unsafe-perm --verbose homebridge-ring homebridge-nest homebridge-rainbird homebridge-tplink-smarthome
# RUN npm install -g --unsafe-perm --verbose hap-nodejs homebridge-broadlink-rm

COPY homebridge-service-generator /usr/sbin/homebridge-service-generator
RUN ln -s /usr/local/lib/node_modules/homebridge/bin/homebridge /usr/sbin/homebridge-bridge \
 && ln -s /usr/local/lib/node_modules/homebridge-config-ui-x/dist/bin/standalone.js /usr/sbin/homebridge-ui
COPY 10-ep-container.sh /etc/container/entrypoint.d/10-ep-container.sh


# RUN apk add --no-cache avahi avahi-compat-libdns_sd avahi-dev dbus jq nodejs npm openssl python3 build-base
# RUN mkdir -p /etc/homebridge \
#  && ln -s /opt/homebridge/config.json /etc/homebridge/config.json
#COPY config.json /opt/homebridge-data/config.json
# /home/homebridge/.homebridge/config.json
# RUN hb-service update-node
# homebridge-eufy-robovac


# ╭――――――――――――――――――――╮
# │ USER               │
# ╰――――――――――――――――――――╯
ARG USER=homebridge
# VOLUME /opt/$USER
RUN /bin/mkdir -p /opt/$USER \
 && /usr/sbin/addgroup $USER \
 && /usr/sbin/adduser -D -s /bin/ash -G $USER $USER \
 && /usr/sbin/usermod -aG wheel $USER \
 && /bin/echo "$USER:$USER" | chpasswd \
 && /bin/chown $USER:$USER -R /opt/$USER
#  && mv /root/.npm /home/$USER/.npm \
#  && /bin/chown $USER:$USER -R /home/$USER/.npm \
#  && mv /usr/local/lib/node_modules/homebridge-platform-helper /usr/local/lib/node_modules/homebridge-platform-helper~ \
#  && ln -s /home/$USER/.npm/_cache /usr/local/lib/node_modules/homebridge-platform-helper
 
 
USER $USER
WORKDIR /home/$USER

