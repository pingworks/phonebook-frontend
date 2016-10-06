#!/bin/sh

set -e

NAME=phonebook-frontend
USER=root

OPTS="--host 0.0.0.0"

DAEMON="/usr/local/bin/bundle"

test -x $DAEMON || exit 1
cd /opt/$NAME 
#bundle install --deployment --local
/usr/local/bin/bundle exec rackup --host 0.0.0.0
