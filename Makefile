VERSION ?= 'latest'

build:
	docker build -t vinhio/nginx:alpine .

run:
	docker run -p 80:80 vinhio/nginx:alpine

release:
	make version VERSION="latest"
	make push VERSION="latest"

version:
	docker tag vinhio/nginx:alpine vinhio/nginx:$(VERSION)

push:
	docker push vinhio/nginx:$(VERSION)
