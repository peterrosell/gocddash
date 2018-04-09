FROM python:2

RUN apt-get update && \
    apt install -y \
        sqlite3
        
# To be used in later version
#        memcached

WORKDIR /app/gocddash

ADD requirements.txt /app/

RUN pip install --no-cache-dir -r /app/requirements.txt

ENTRYPOINT [ "/entrypoint.sh"]

ADD entrypoint.sh /
ADD gocddash/ /app/gocddash/
