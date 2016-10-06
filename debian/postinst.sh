#!/bin/bash

# TODO
# create startscript for rack server

# cd /opt/phonebook-frontend
# nohup bundle exec rackup config.ru &

# change ownership of config.js
if id deploy >/dev/null 2>&1; then
  chown deploy:deploy /opt/phonebook-frontend/assets/javascript/config.js
fi
sed -i -e "s;__DOMAIN__;$(dnsdomainname);g" /opt/phonebook-frontend/assets/javascript/config.js
