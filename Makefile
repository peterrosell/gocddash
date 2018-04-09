include commons.mk

DOCKER_IMAGE_NAME=$(DOCKER_REGISTRY)gocddash


build:
	docker build -t $(DOCKER_IMAGE_NAME) .

run:
	docker run -i -t --rm --name gocddash \
		-p 5000:5000 \
		--dns 10.13.16.2 \
		$(DOCKER_IMAGE_NAME):latest \
			--go-server-url http://go.pagero.local \
			--go-server-user dash \
			--go-server-passwd board 

release: export VERSION:=$(shell grep "version" setup.py | sed "s/.*'\(.*\)'.*/\1/")
