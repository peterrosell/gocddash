#!/bin/bash -e

# To be used in later version
#/usr/bin/memcached -m 64 -p 11211 -l 127.0.0.1 -u root &

cd /app/gocddash
python ./app.py $@
