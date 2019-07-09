FROM quay.io/spivegin/tlmcaddy

# TLMTEXT APIs Attachement build
# created by oyoshi


RUN mkdir /opt/tlm/ /opt/dumb_init/


ADD ./files/bash/entry.sh /opt/config/entry.sh
ADD https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip /tmp/ngrok.zip
ADD ./files/Caddyfile /opt/caddy/Caddyfile
ADD https://raw.githubusercontent.com/adbegon/pub/master/AdfreeZoneSSL.crt /usr/local/share/ca-certificates/
ADD ./files/dumb-init/dumb-init_1.2.0_amd64.deb /opt/dumb_init/

RUN dpkg -i /opt/dumb_init/dumb-init_1.2.0_amd64.deb && \
    rm -rf /opt/dumb_init &&\
    update-ca-certificates --verbose &&\
    cd /tmp/ && unzip ngrok.zip && mv ngrok /opt/bin/ && cd /opt/ &&\
    chmod +x /opt/bin/ngrok &&\
    ln -s /opt/bin/ngrok /bin/ngrok &&\
    chmod +x /opt/config/entry.sh &&\
    apt update && apt -y upgrade &&\
    apt-get autoclean && apt-get -y autoremove &&\
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

WORKDIR /root/

ENV NGROK_API_KEY=enterYourAPIKey \
    TLM_FORWARD=host:port \
    TESTING=TRUE

EXPOSE 80
ENTRYPOINT ["/opt/config/entry.sh"]
#CMD ["/opt/config/entry.sh"]