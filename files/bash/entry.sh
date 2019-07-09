#!/usr/bin/dumb-init /bin/sh

cd ~
ngrok authtoken $NGROK_API_KEY
caddy -conf /opt/caddy/Caddyfile  &
ngrok http 0.0.0.0:80 
