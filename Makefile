VERSION := 1.14.0

IMAGE := sunaoka/laravel-pint

PLATFORM := linux/arm64,linux/amd64

BUILDER := docker-laravel-pint-builder

BUILDER_ARGS := --build-arg VERSION=$(VERSION) -t $(IMAGE):latest -t $(IMAGE):$(VERSION)

all: build

setup:
	(docker buildx ls | grep $(BUILDER)) || docker buildx create --name $(BUILDER)

build: setup
	docker buildx use $(BUILDER)
	docker buildx build --platform $(PLATFORM) $(BUILDER_ARGS) --push .
	docker buildx rm $(BUILDER)

.PHONY: all setup build
