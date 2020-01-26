# Experimental Distroless image w. nginx 1.17.8 + PageSpeedMod ???1.13.35 beta 2
# date: 2020-01-26
# https://hub.docker.com/r/simmessa/nginx-distroless/

# Build env, doesn't need to be slim
FROM gcc:latest AS build-env
MAINTAINER simmessa@gmail.com
WORKDIR /tmp

ENV DEPS curl build-essential zlib1g-dev libpcre3 libpcre3-dev unzip uuid-dev wget libssl-dev libgd-dev libgeoip-dev

# Apt and deps
RUN apt-get -qq update && apt-get install -yqq $DEPS 

# COPY nginx-1.17.8.tar.gz /tmp/
# COPY openssl-1.1.1d.tar.gz /tmp/nginx-1.17.8/

ADD staticbuild.bash /tmp/staticbuild.bash
RUN bash /tmp/staticbuild.bash

# Distroless image

FROM gcr.io/distroless/base:latest

COPY --from=build-env /opt/nginx/nginx /opt/nginx/nginx

COPY nginx.conf /etc/nginx/nginx.conf
COPY mime.types /etc/nginx/mime.types
COPY index.html /var/www/html/index.html

#expose nginx
EXPOSE 80

ENTRYPOINT ["/opt/nginx/nginx", "-g", "daemon off;pid /var/run/nginx.pid;"]
