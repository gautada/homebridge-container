# Homebridge

ff 

## Abstract

[Homebridge](https://homebridge.io) brings HomeKit support where there is none. Homebridge allows you to integrate with smart home devices that do not natively support HomeKit. There are over 2,000 Homebridge plugins supporting thousands of different smart accessories.

## Features

Hombridge offers a set of plug-in to incorporate specific device support.  Inuded are my specific devices that I use personally and should be considered for reference. 

- UI
- Thrmostat - Nest
- Doorbell(Camera) - Ring
- Remote Control - BroadLink RM Pro
- Lawn Sprinkler - Rainbird
- Electrical Outlets - TPLink Smarthome
`

### Feature Detail

The included plug-in descriptions with links to various sub-projects that provide the details for specific devices.

#### Thermostat

[Homebridge Nest Thermostat](https://github.com/chrisjshull/homebridge-nest) Integrate your [Nest Thermostat](https://store.google.com/us/category/google_nest?hl=en-US), Temperature Sensors, Nest Protect, and Nest x Yale Lock devices into your HomeKit system. Both Nest Accounts (pre-August 2019) and Google Accounts are supported.

#### Doorbell(Camera)

[Homebridge Ring](https://github.com/dgreif/ring/tree/main/packages/homebridge-ring) provides a platform for [Ring Doorbells](https://ring.com/doorbell-cameras), Ring Cameras, the Ring Alarm System, Ring Smart Lighting, and third party devices that connect to the Ring Alarm System.

#### Remote Control

[Homebridge Broadlink RM](https://github.com/kiwi-cam/homebridge-broadlink-rm) this plugin allows you to control your RM Mini and RM Pro with HomeKit using the Home app and Siri. This is used to control non-smart devices.

#### Lawn Sprinkler

[Homebridge Rainbird](https://github.com/donavanbecker/homebridge-rainbird) allows you to access your RainBird Controller from HomeKit with Homebridge.

#### Electrical Outlets

[Homebridge TPLink Smarthome](https://github.com/plasticrake/homebridge-tplink-smarthome) Allows the control of TPLink Smarthome plugs.

## Environment

###  Development

All development is controled by the default `docker-compose.yml` capability.
 
### Testing

## Architecture

### Context

![Context Diagram](https://plantuml.com/plantuml/svg/bLJ9JXmn4BtFLnIj7422cGkdA8d49X518ZHm2BaWJxjcsi9sMROR64NvzrIxzraGENMvbkTNLSzze6okIudmvU9qTd4wTQNHtoO7O-_J1Tc8R_6Tg50M_TwuSMJHxgk_N5jXLBulYaxJslJbawYYHiWQKd2fnCeB0oTmJGONNiaLPfF9EPLM2hy-p0fsPyUGNJVVXm91uf8PIwXYe6mglL4nEu8_4xX37yW-NRt5mwmCwAkY7sWMjNK69jb0IuWCbI1Ql27K1Bh9r5XLvZD76YutjNdcd5RObW5QiT0OO4sb1-4SH8ASo4jbHKGGLlBHHa-wlbcKaOo8YYo8FCSGo2ikNteoO4eTbUDXlQ2Lv4E5vJm67YO8XYdGitaCLPCdIyhvMxKGqIz5ZbDczqah-_mrAs9quVDi9l45DJbUDJFJECt9p2JNLUj976PjZyFkwywRpJJDzwVlV1yla7jxLR60O8IFxL1V57V4KnOH986b23m4nHpM44hdY3ERkUqWsrywLRHZ7RmyRoWmyKOLWzDF3146hkrgoJjPeDPLzkN0dYkxWiwnNHUSPvQwrjAjUBLmF_JCENMXlEoz2O3NlGDhmGtBK9NT5qBof2frd7VENu-_-LKqvnrCUCz8gJfPCCSSURY9nwCmeX2zQxlSwNALhhdIc4UlSg7XhlKztC4jqsySH-sREio4DCecsRS6moxLglHfqVLpghUMPDdBaL7-JkQe-pSvU4yz2AUbf46mpR_dJPQx4iRovF-L4VN8Kc97UJEjkxAALQ8RGlU9Wuks6VHfOpasI-zonz5nvNkeGvbkOWvZ7qSS2NWJSXJyE6Olv4t0Fl8V33jXRz7h8Xz7wtI-2TO5TcFz0m00)

### Container

{![Container Diagram(Link to image)}

### Components

{![Component Diagram(Link to image)}

## Administration

### Checklist

- [ ] README conforms to the [gist](https://gist.github.com/gautada/ec549c846e8e50daf355d01b06eb0665)
- [ ] .gitignore conforms to the [gist](https://gist.github.com/gautada/3a0a4a76d3c7e4539e71fc02c7f599ad)
- [ ] Confirm the drone.yml file
- [ ] Volume folders are present (development-volume & backup-volume)
- [ ] docker-compose(.yml) works
- [ ] Manifst folder present (and origin to private repository is correct
- [ ] Issue List is linked to proper URI
- [ ] Signoff ({date and signature of last check})
- [ ] Confirm backup (maybe add to testing layer)
- [ ] Confirm healthcheck (maybe add to testing layer)
- [ ] Regenerate all architecture images


### Issues

The official to list is kept in a [GitHub Issue List]{(https://github.com/gautada/{repo}/issues)}

## Notes






UI: https://github.com/oznu/homebridge-config-ui-x/wiki/Config-Options
https://www.devwithimagination.com/2020/02/02/running-homebridge-on-docker-without-host-network-mode/

            "log": {
            #     "tail": "journalctl -o cat -n 100 -f -u homebridge"
            }
                        "log": { "method": "file", "path": "/Users/username/.homebridge/homebridge.log"},

EXPOSE 8080/tcp # UI
EXPOSE 51400/tcp # Homebridge port
EXPOSE 5353/udp # Multicast DNS mDNS
EXPOSE 41000/udp

         "showRequestResponse": true
         "logging": "debug"
            
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

