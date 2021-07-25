.DEFAULT_GOAL := build

all: build-push-7.1 build-push-7.2 build-push-7.3 build-push-7.4 build-push-8.0 build-push-8.0-cli

build: build-7.1 build-7.2 build-7.2 build-7.3 build-7.4 build-8.0 build-8.0-cli

build-push-7.1: build-7.1 push-7.1

build-push-7.2: build-7.2 push-7.2

build-push-7.3: build-7.3 push-7.3

build-push-7.4: build-7.4 push-7.4

build-push-8.0: build-8.0 push-8.0

build-push-8.0-cli: build-8.0-cli push-8.0-cli


build-7.1:
	@echo "Building image tag 7.1"
	docker build -t dptsi/laravel-web-dev:7.1 7.1
	@echo "Image tag 7.1 successfully built"

push-7.1:
	@echo "Pushing image tag 7.1"
	docker image push dptsi/laravel-web-dev:7.1
	@echo "Image tag 7.1 successfully pushed"

build-7.2:
	@echo "Building image tag 7.2"
	docker build -t dptsi/laravel-web-dev:7.2 7.2
	@echo "Image tag 7.2 successfully built"

push-7.2:
	@echo "Pushing image tag 7.2"
	docker image push dptsi/laravel-web-dev:7.2
	@echo "Image tag 7.2 successfully pushed"

build-7.3:
	@echo "Building image tag 7.3"
	docker build -t dptsi/laravel-web-dev:7.3 7.3
	@echo "Image tag 7.3 successfully built"

push-7.3:
	@echo "Pushing image tag 7.3"
	docker image push dptsi/laravel-web-dev:7.3
	@echo "Image tag 7.3 successfully pushed"

build-7.4:
	@echo "Building image tag 7.4"
	docker build -t dptsi/laravel-web-dev:7.4 7.4
	@echo "Image tag 7.4 successfully built"

push-7.4:
	@echo "Pushing image tag 7.4"
	docker image push dptsi/laravel-web-dev:7.4
	@echo "Image tag 7.4 successfully pushed"

build-8.0:
	@echo "Building image tag 8.0"
	docker build -t dptsi/laravel-web-dev:8.0 8.0
	@echo "Image tag 8.0 successfully built"

push-8.0:
	@echo "Pushing image tag 8.0"
	docker image push dptsi/laravel-web-dev:8.0
	@echo "Image tag 8.0 successfully pushed"
	

build-8.0-cli:
	@echo "Building image tag 8.0-cli"
	docker build -t dptsi/laravel-web-dev:8.0-cli 8.0-cli
	@echo "Image tag 8.0-cli successfully built"

push-8.0-cli:
	@echo "Pushing image tag 8.0-cli"
	docker image push dptsi/laravel-web-dev:8.0-cli
	@echo "Image tag 8.0-cli successfully pushed"