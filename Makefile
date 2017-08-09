
IMAGE_VERSION=24
JAVA_VERSION=8u131
NODE_VERSION=8.2.1
IMAGE_NAME=chrisgarrett/react-native-android

all: build

prep:
	VERSION=${IMAGE_VERSION} JAVA_VERSION=${JAVA_VERSION} NODE_VERSION=${NODE_VERSION} envsubst '$${VERSION} $${JAVA_VERSION} $${NODE_VERSION}' < ./templates/Dockerfile.template > Dockerfile
	VERSION=${IMAGE_VERSION} JAVA_VERSION=${JAVA_VERSION} NODE_VERSION=${NODE_VERSION} envsubst '$${VERSION} $${JAVA_VERSION} $${NODE_VERSION}' < ./templates/README.md.template > README.md
	VERSION=${IMAGE_VERSION} JAVA_VERSION=${JAVA_VERSION} NODE_VERSION=${NODE_VERSION} envsubst '$${VERSION} $${JAVA_VERSION} $${NODE_VERSION}' < ./templates/docker-compose.yml.template > docker-compose.yml

build: prep
	docker build --rm=true -t ${IMAGE_NAME}:${IMAGE_VERSION} .

run:
	docker run --rm -it \
		-v `pwd`/examples/links/app:/work/app \
		-v `pwd`/examples/links/libs/mylib1:/work/libs/mylib1 \
		${IMAGE_NAME}:${IMAGE_VERSION} \
		bash

up: down
	docker-compose -p links up

down:
	docker-compose -p links rm -f

restart:
	docker-compose -p links restart links_app
