VERSION := 1.25.0

IMAGE := sunaoka/laravel-pint

PLATFORM := linux/arm64,linux/amd64

BUILDER := docker-laravel-pint-builder

BUILDER_ARGS := --build-arg VERSION=$(VERSION) -t $(IMAGE):$(VERSION) -t $(IMAGE):latest

all: build

setup:
	(docker buildx ls | grep $(BUILDER)) || docker buildx create --name $(BUILDER)

build: setup
	docker buildx use $(BUILDER)
	docker buildx build --rm --no-cache --platform $(PLATFORM) $(BUILDER_ARGS) --push .
	docker buildx rm $(BUILDER)

release:
	git checkout develop
	git add .
	git commit -m "Update v$(VERSION)"
	git checkout main
	git merge develop --no-ff -m "Merge develop into main for v$(VERSION)"
	git tag -a v$(VERSION) -m "Release v$(VERSION)"
	git checkout develop
	git push origin main develop --tags

.PHONY: all setup build release
