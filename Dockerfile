FROM alpine:3.12.1 as config-alpine

RUN apk add --no-cache tzdata

RUN cp -v /usr/share/zoneinfo/America/New_York /etc/localtime
RUN echo "America/New_York" > /etc/timezone

FROM alpine:edge

EXPOSE 8080/tcp
EXPOSE 51400/tcp
EXPOSE 5353/udp

RUN apk add --no-cache  --update nodejs-current \
                                 nodejs-current-npm \
                                 sudo

COPY --from=config-alpine /etc/localtime /etc/localtime
COPY --from=config-alpine /etc/timezone /etc/timezone

# RUN npm install -g homebridge homebridge-config-ui-x
RUN npm install -g --unsafe-perm debug@4.3.1 homebridge homebridge-config-ui-x

# RUN hb-service update-node

# homebridge-eufy-robovac
RUN npm install -g --unsafe-perm homebridge-ring \
                                 homebridge-nest \
                                 homebridge-tplink-smarthome
  
COPY config.json /root/.homebridge/config.json
COPY entrypoint /entrypoint

ENTRYPOINT ["/usr/bin/homebridge", "-D", "-Q"]
