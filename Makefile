VENV := venv
IMAGE_NAME := playground
VERSION := 0.0.1

all: ping

ping:
	@echo "$@: pong"

venv: requirements.txt
	python -m venv $(VENV)
	$(VENV)/bin/pip install -U -r requirements.txt

run: venv
	$(VENV)/bin/python playground.py

clean:
	rm -rf $(VENV)

version:
	@if [ -z "$(VERSION)" ]; then \
		echo "$@: VERSION is not set"; \
		false; \
	else \
		echo "$@: VERSION is $(VERSION)"; \
	fi

docker-build:
	@docker rmi $(IMAGE_NAME):$(VERSION) || true
	@docker rmi $(IMAGE_NAME):latest || true
	docker build -t $(IMAGE_NAME):$(VERSION) -f Dockerfile .
	docker tag $(IMAGE_NAME):$(VERSION) $(IMAGE_NAME):latest
	@echo "$@: built image $(IMAGE_NAME):$(VERSION), $(IMAGE_NAME):latest"

docker-run: docker-build
	docker run -d --name $(IMAGE_NAME) $(IMAGE_NAME):$(VERSION)

# docker run --itd --name $(IMAGE_NAME) $(IMAGE_NAME):$(VERSION)
# docker exec -it $(IMAGE_NAME) /bin/bash

docker-clean:
	docker rm -f $(IMAGE_NAME)

# docker rm -f $(docker ps --all -q) 

.PHONY: all ping venv run clean version docker-build docker-run docker-clean
