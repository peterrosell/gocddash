include commons.mk

DOCKER_IMAGE_NAME=$(DOCKER_REGISTRY)gocddash


ifdef DNS_SERVER
  DOCKER_RUN_FLAGS += --dns $(DNS_SERVER)
endif

build:
	docker build $(DOCKER_FLAGS) -t $(DOCKER_IMAGE_NAME) .

run:
	docker run -i -t --rm --name gocddash \
		-p 5000:5000 \
		$(DOCKER_RUN_FLAGS) \
		$(DOCKER_IMAGE_NAME):latest \
			--go-server-url http://go.pagero.local \
			--go-server-user dash \
			--go-server-passwd board 

release: export VERSION:=$(shell grep "version" setup.py | sed "s/.*'\(.*\)'.*/\1/")
