#!/usr/bin/dumb-init /bin/sh

cd ~
ngrok authtoken $NGROK_API_KEY
cd /opt/tlmngrok
caddystart start &
ngrok http 0.0.0.0:80 
