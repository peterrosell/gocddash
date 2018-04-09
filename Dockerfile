FROM python:2-alpine3.7

RUN apk add --no-cache sqlite
        
# To be used in later version
#        memcached

WORKDIR /app/gocddash

ADD requirements.txt /app/

RUN pip install --no-cache-dir -r /app/requirements.txt

ENTRYPOINT [ "/entrypoint.sh"]

ADD entrypoint.sh /
ADD gocddash/ /app/gocddash/
