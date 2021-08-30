# ------------------------------------------------------------- [STAGE] INIT
ARG ALPINE_TAG=0.0.0

FROM alpine:$ALPINE_TAG as config-alpine

RUN apk add --no-cache tzdata

RUN cp -v /usr/share/zoneinfo/America/New_York /etc/localtime
RUN echo "America/New_York" > /etc/timezone

FROM alpine:$ALPINE_TAG

EXPOSE 8080/tcp
EXPOSE 51400/tcp
EXPOSE 5353/udp

RUN apk add --no-cache  --update nodejs npm sudo

COPY --from=config-alpine /etc/localtime /etc/localtime
COPY --from=config-alpine /etc/timezone /etc/timezone

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
                                   /etc/homebridge

USER $USER
WORKDIR /home/homebridge

RUN mkdir /home/homebridge/.homebridge \
 && ln -s /etc/homebridge/conf.json /home/homebridge/.homebridge/config.json

ENTRYPOINT ["/usr/local/bin/homebridge"]
CMD ["-D", "-Q"]


