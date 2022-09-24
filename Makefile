VERSION ?= 'latest'

build:
	docker build -t vinhio/nginx:alpine .

run:
	docker run -p 80:80 vinhio/nginx:alpine

version:
	#make version VERSION="latest"
	docker tag vinhio/nginx:alpine vinhio/nginx:$(VERSION)

push:
	#make push VERSION="latest"
	docker push vinhio/nginx:$(VERSION)