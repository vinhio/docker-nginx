all: build run

build:
	docker build -t vinhio/nginx:alpine .

start: run

run:
	docker run -p 80:80 vinhio/nginx:alpine

