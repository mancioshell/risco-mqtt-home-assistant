# risco-mqtt-home-assistant

This project is  highly inspired by [risco-mqtt-bridge](https://github.com/lucacalcaterra/risco-mqtt-bridge) by [Luca Calcaterra](https://github.com/lucacalcaterra) but differs from it because it uses Risco REST API sniffed from [iRISCO](https://play.google.com/store/apps/details?id=com.homeguard&hl=it) app. 

## Motivations

Sometimes Risco Cloud Web API (that is the basis on which [risco-mqtt-bridge](https://github.com/lucacalcaterra/risco-mqtt-bridge) was developed) does not respond to sensors change state unless you force the state update of the alarm control panel. So I have decided to change the source of information of risco alarm panel from Web APIs to REST APIs like in the mobile App.

**risco-mqtt-home-assistant** supports also multipartitions.

## Requirements
* Node.js (currently tested with >=ver. 10.x)
* Mqtt Server - e.g. Mosquitto, HiveMQ, etc.
* Home Assistant

## Features
* Interaction with RISCO alarm control panel like in [iRISCO](https://play.google.com/store/apps/details?id=com.homeguard&hl=it) mobile app.
* Interaction with MQTT Alarm Control Panel integration in Home Assistant.
* Interaction with MQTT Binary Sensor integration in Home Assistant.
* Home Assistant MQTT Auto Discovery.
* RISCO multipartitions.

## Installation

1. Create a docker-compose.yaml file with the following content:

```
version: "2.1"
services:
  risco-mqtt-home-assistant:
    image: dockerbytes/risco-mqtt-home-assistant:latest
    container_name: risco-mqtt-home-assistant
    env_file: .risco.env
    restart: unless-stopped
```

2. In the same directory create an .risco.env with the following content (no quotes needed):

```
RISCO_EMAIL=
RISCO_PASSWORD=
CENTRAL_PIN_CODE=
MQTT_HOST=
```

The following variables can be added in case required to .risco.env (no quotes needed):

```
MQTT_USER=
MQTT_PASSWORD=
MQTT_PORT=
RISCO_INTERVAL_POLLING=
HOME_ASSISTANT_DISCOVERY_PREFIX=
```

3. In the same directory as your docker-compose.yaml run the following command:

```
docker-compose up
```

## Subscribe Topics

**risco-mqtt-home-assistant** subscribes at startup one topic for every partition in your risco alarm panel configuration.

Topics format is `riscopanel/alarm/<partition_id>/set` where **partition_id** is the id of the partition

Payload could be : **disarmed** if risco panel is in disarmed mode,**armed_home** if risco panel is in armed at home mode and **armed_away** if risco panel is in armed away mode.

## Publish Topics

risco-mqtt-home-assistant publishes one topic for every partition and for every zones in your risco alarm panel configuration.

Partitions topics format is `riscopanel/alarm/<partition_id>/status` where **partition_id** is the id of the partition

Payload could be : **disarmed** if risco panel is in disarmed mode,**armed_home** if risco panel is in armed at home mode and **armed_away** if risco panel is in armed away mode.

Zones topics format is `riscopanel/alarm/<partition_id>/sensor/<zone_id>/status` where **partition_id** is the id of the partition and **zone_id** is the id of the zone.

Payload could be : **triggered** if zone is curently triggered, and **idle** if zone is currently idle.

In addition to every zones, risco-mqtt-home-assistant publishes a topic for every zone with all the info of the zone in the paylaod in json format. Topics format is `riscopanel/alarm/<partition_id>/sensor/<zone_id>` where **partition_id** is the id of the partition and **zone_id** is the id of the zone.

## Home Assistant Auto Discovery

risco-mqtt-home-assistant supports [mqtt auto discovery](https://www.home-assistant.io/docs/mqtt/discovery/) feature.

Default `<discovery_prefix>` is **homeassistant**. You can change it by overwriting the value within **home-assistant-discovery-prefix** config.
