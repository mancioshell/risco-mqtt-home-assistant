#/bin/bash -x

if [ -z $RISCO_EMAIL  ] ; then
  echo RISCO_EMAIL variable has not been set
  exit 1
elif [ -z $RISCO_PASSWORD  ] ; then
  echo RISCO_PASSWORD variable has not been set
  exit 1
elif [ -z $CENTRAL_PIN_CODE  ] ; then
  echo CENTRAL_PIN_CODE variable has not been set
  exit 1
elif [ -z $MQTT_HOST  ] ; then
  echo MQTT_HOST variable has not been set
  exit 1
fi

cat > config.json <<EOF
{
    "username": "${RISCO_EMAIL}",
    "password": "${RISCO_PASSWORD}",
    "pin": "${CENTRAL_PIN_CODE}",
    "language-id": "${LANGUAGE_ID-nl}",
    "mqtt-url": "${MQTT_PROTOCOL-mqtt}://${MQTT_HOST}:${MQTT_PORT-1883}",
    "mqtt-username": "${MQTT_USERNAME}",
    "mqtt-password": "${MQTT_PASSWORD}",
    "interval-polling": "${RISCO_INTERVAL_POLLING-5000}",
    "home-assistant-discovery-prefix": "${HOME_ASSISTANT_DISCOVERY_PREFIX-homeassistant}"
}
EOF

npx risco-mqtt-home-assistant
