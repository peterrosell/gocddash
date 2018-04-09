.PHONY: help

USE_NO_CACHE ?= false
ifeq ($(USE_NO_CACHE),true)
  DOCKER_FLAGS += --no-cache
endif

help: ## Show this help
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS=OFS=":"} {$$1=""; sub(/\:/, "")}'1 | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

tag-and-push:
	git tag -a ${VERSION} -m "Releasing ${VERSION}" && \
	git push origin master ${VERSION} && \
	docker tag $(DOCKER_IMAGE_NAME):latest $(DOCKER_IMAGE_NAME):${VERSION} && \
	docker push $(DOCKER_IMAGE_NAME):${VERSION}

check-env-vars:
	@if [ -z "$$VERSION" ]; then \
	  echo "Environment variable VERSION is not set. Can't make a release"; \
	  exit 2; \
	fi

check-source-status:
	@if [ -z "$$(git status -uno --porcelain)" ]; then \
	  echo "this branch is clean, no need to push..."; \
	else \
	  git status -uno;  \
	  echo "Source code need to be commited/pushed"; \
	  exit 3; \
	fi

release: check-env-vars check-source-status build check-source-status tag-and-push ## Build project from scratch, tags and push to docker and git (env VERSION=<release version>)
