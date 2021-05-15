FROM node:latest

WORKDIR /usr/src/app

RUN npm install risco-mqtt-home-assistant

COPY index.js ./node_modules/risco-mqtt-home-assistant/index.js

COPY run.sh /run.sh

CMD [ "/run.sh" ]
