APP_NAME:=$(shell basename -s .git `git config --get remote.origin.url`)
APP_VER:=$(shell git rev-parse --abbrev-ref HEAD)
APP_PORT?=8888
NAMESPACE:=stage

.PHONY: build run create deploy destroy

all: build create deploy #destroy

build:
	@docker build -t ${APP_NAME}:${APP_VER} -f build/Dockerfile .

create:
	@kind create cluster --name ${APP_NAME} --config ./deploy/cluster-config.yaml

deploy:
	@kind load docker-image ${APP_NAME}:${APP_VER} --name ${APP_NAME}
	@helm upgrade --install ${APP_NAME} ./deploy/chart \
		--set service.name=${APP_NAME} \
		--set image.tag=${APP_VER} \
		--set containerPorts.http=${APP_PORT} \
		--create-namespace \
		--namespace=${NAMESPACE} \
		--set APP_PORT=${APP_PORT} \
		--atomic

destroy:
	@kind delete cluster --name ${APP_NAME}