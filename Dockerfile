FROM alpine:3.16.2

WORKDIR /home/www/app
EXPOSE 80 443
ENTRYPOINT ["/init"]

# Labels.
LABEL com.jivecode.schema-version="1.0" \
    com.jivecode.build-date=$BUILD_DATE \
    com.jivecode.name="vinhio/nginx:alpine" \
    com.jivecode.description="Docker Nginx" \
    com.jivecode.url="http://www.jivecode.com" \
    com.jivecode.vcs-url="https://github.com/vinhio/docker-nginx" \
    com.jivecode.vcs-ref=$VCS_REF \
    com.jivecode.vendor="JiveCode" \
    com.jivecode.version=$BUILD_VERSION \
    com.jivecode.docker.cmd="docker run -ti -u www vinhio/nginx:alpine bash"

### Install packages
RUN apk add --update --no-cache bash \
	curl \
	nginx

### Install S6 overlay
RUN curl -LSs -o /tmp/s6-overlay-amd64.tar.gz \
    https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.3/s6-overlay-amd64.tar.gz && \
    tar xzf /tmp/s6-overlay-amd64.tar.gz -C / && \
    rm -f /tmp/s6-overlay-amd64.tar.gz

### Copy configuration files
ADD rootfs /

### Change permission folders
RUN nginxUID=`id -u nginx` &&\
    nginxGID=`id -g nginx` &&\
    deluser nginx &&\
    addgroup -g $nginxGID nginx &&\
    adduser -S -u $nginxUID -G nginx -h /home/www -s /sbin/nologin nginx &&\
    chown -R nginx:nginx /home/www/app
