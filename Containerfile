ARG ALPINE_VERSION=3.16.0

# ╭――――――――――――――――---------------------------------------------------------――╮
# │                                                                           │
# │ STAGE 1: homebridge-container                                                 │
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

EXPOSE 8080/tcp
EXPOSE 51400/tcp
EXPOSE 5353/udp
EXPOSE 41000/udp

RUN apk add --no-cache  --update nodejs npm

COPY config.json /opt/homebridge-data/config.json
# /home/homebridge/.homebridge/config.json

RUN npm install -g --unsafe-perm debug@4.3.1 homebridge homebridge-config-ui-x

# RUN hb-service update-node
# homebridge-eufy-robovac

RUN npm install -g --unsafe-perm homebridge-ring \
                                 homebridge-nest \
                                 homebridge-tplink-smarthome

ARG USER=homebridge
RUN addgroup $USER \
 && adduser -D -s /bin/sh -G $USER $USER \
 && echo "$USER:$USER" | chpasswd

RUN chown homebridge:homebridge -R /home/homebridge \
 && chmod 777 -R /opt/homebridge-data

USER $USER
WORKDIR /home/homebridge

RUN mkdir /home/homebridge/.homebridge \
 && ln -s /opt/homebridge-data/config.json /home/homebridge/.homebridge/config.json

CMD ["/usr/local/bin/homebridge", "-D", "-Q"]


