# Homebridge

[Homebridge](https://homebridge.io) brings HomeKit support where there is none. Homebridge allows you to integrate with smart home devices that do not natively support HomeKit. There are over 2,000 Homebridge plugins supporting thousands of different smart accessories.

UI: https://github.com/oznu/homebridge-config-ui-x/wiki/Config-Options

## Container

### Versions

Homebridge NodeJS code is just installed using NPM and version is established from the installed/running scripts.

```
/usr/local/bin/homebridge --version | sed -n 2p
```

- [September 8, 2021](https://github.com/homebridge/homebridge/tags) - Active version is 1.3.4 as tag [1.3.4](https://github.com/homebridge/homebridge/tags)

### Manual Build

docker build --build-arg ALPINE_VERSION=3.16.0 --build-arg HOMEBRIDGE_VERSION=1.4.1 --file Containerfile --label revision="$(git rev-parse HEAD)" --label version="$(date +%Y.%m.%d)" --no-cache --tag homebridge:build .

docker run --interactive --name homebridge --publish 8080:8080 --publish 51400:51400 --publish 5354:5353/udp --publish 41000:41000/udp --rm --tty --volume ~/Workspace/homebridge/homebridge-container:/opt/homebridge homebridge:build

```
docker build --build-arg ALPINE_TAG=3.14.1 --build-arg VERSION=1.3.4 --tag homebridge:dev -f Containerfile . 
docker run -i -p 3000:3000 -t --name homebridge --rm homebridge:dev 
Requires ```--net=host```

```

## Plugins

Currently the homebridge is configured to support these personal devices:

### Ring

[Homepage|https://ring.com]
[Product - Video Doorbell Pro|https://ring.com/products/video-doorbell-pro]
[Plugin - homebridge-ring v9.12.8|https://github.com/dgreif/ring/tree/master/homebridge#homebridge-ring]

The **Ring Video Doorbell** is the company's flagship product; it is a smart doorbell that contains a high-definition camera, a motion sensor, and a microphone and speaker for two-way audio communication. It integrates with an associated mobile app, Neighbors, which allows users to view real-time video from the camera, receive notifications when the doorbell is rung, and communicate with visitors at the door via the integrated speaker and microphone. It is also capable of operating as a surveillance camera, and can automatically trigger recordings when rung, or when its motion sensors are activated. A second-generation model, Ring Doorbell 2, was released in 2017, with updated hardware and a 1080p camera with improved low-light performance, that does not rely solely on Wi-Fi, unlike the original model.

#### Notes 

From time-to-time the **refresh tokens** need to be updated via [credential refresh|https://github.com/dgreif/ring/wiki/Refresh-Tokens] using ```ring-auth-cli```.

```
/usr/local/bin/ring-auth-cli
```

### Nest

[Homepage|https://store.google.com/us/category/connected_home]
[Product - Nest(2nd Gen?)|https://store.google.com/us/product/nest_learning_thermostat_3rd_gen]
[Plugin - homebridge-nest v4.5.1|https://github.com/chrisjshull/homebridge-nest#readme]

The **Nest Learning Thermostat** (or **Nest Thermostat**) is a smart thermostat developed by Nest Labs and designed by Tony Fadell, Ben Filson, and Fred Bould. It is an electronic, programmable, and self-learning Wi-Fi-enabled thermostat that optimizes heating and cooling of homes and businesses to conserve energy.

The device is based on a machine learning algorithm: for the first weeks users have to regulate the thermostat in order to provide the reference data set. The thermostat can then learn people's schedule, at which temperature they are used to and when. Using built-in sensors and phones' locations, it can shift into energy saving mode when it realizes nobody is at home.

#### Notes

To configure the Nest to work with the Homebridge system requires an elaborate set of credentials to be created and enabled.  Please refer to [Using a Google Account|https://github.com/chrisjshull/homebridge-nest#using-a-google-account] for help on configuring the settings of this plugin.

Also refer to [Feature Options|https://github.com/chrisjshull/homebridge-nest#feature-options] for more information regarding the setup of featrues.

### TP-Link Kasa Smart Home

[Homepage|https://www.kasasmart.com/us]
[Product - Kasa Smart Wi-Fi Plug Lite (HS103)|https://www.kasasmart.com/us/products/smart-plugs/kasa-smart-wifi-plug-lite-hs103p2]
[Product - homebridge-tplink-smarthome v6.1.0|https://github.com/plasticrake/homebridge-tplink-smarthome#readme]

#### Notes

The plug has to be configured on the iOS device and onboarded onto the network.  Next, assign a static network IP then configure the device via the homebridge ui.

## Potential Plugins

Eufy Vacuum Cleaner
eero network

## Notes

```
| Ports      | Description         | Pod            | Access    |
| ---------- | ------------------- | -------------- | --------- |
| 80         | HTTP/S User Inter.  | 8080           | ingress   |
| 514000     | Homebridge Port     | 514000         | host      |
| 5353       | Avahi dns? tcp/udp  | 5353           | host      |
```


- [Notes on Docker without Host Network Mode](https://www.devwithimagination.com/2020/02/02/running-homebridge-on-docker-without-host-network-mode/)
- Kubernetes Service maps ports pod:8080 to service:80
- Kubernetes Deployment must include ```hostNetwork: true```

