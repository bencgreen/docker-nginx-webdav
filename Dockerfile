FROM bcgdesign/nginx:alpine-3.13-1.4.2

LABEL maintainer="Ben Green <ben@bcgdesign.com>" \
    org.label-schema.name="Nginx WebDAV" \
    org.label-schema.version="latest" \
    org.label-schema.vendor="Ben Green" \
    org.label-schema.schema-version="1.0"

ARG NGINX_VERSION

ENV \
    # set to "r" or "rw" to enable read-only / read-write access
    DAV_ACCESS="r" \
    # set to "PUT DELETE MKCOL COPY MOVE" (or any variation) to enable full write access
    DAV_METHODS="off"

ARG NGINX_VERSION=1.18.0-r13
RUN apk -U upgrade \
    && apk add \
        nginx-mod-http-dav-ext=${NGINX_VERSION} \
    && rm -rf /var/cache/apk/* /www/* /tmp/*

COPY ./overlay /
