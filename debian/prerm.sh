#!/bin/bash

# kill running ruby app
[ -x /etc/init.d/phonebook-frontend ] && /etc/init.d/phonebook-frontend stop

exit 0
