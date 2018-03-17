# OpenResty Proxy Server
# https://github.com/openresty/docker-openresty

FROM openresty/openresty:1.21.4.1-alpine

# Create nginx user and group
RUN addgroup -g 101 -S nginx \
    && adduser -S -D -H -u 101 -h /var/cache/nginx -s /sbin/nologin -G nginx -g nginx nginx

# Create required directories
RUN mkdir -p /etc/nginx/conf.d \
    && chown -R nginx:nginx /etc/nginx/conf.d \
    && chmod 755 /etc/nginx/conf.d

# Redirect logs to stdout/stderr for Docker logging
RUN ln -sf /dev/stdout /usr/local/openresty/nginx/logs/access.log \
    && ln -sf /dev/stderr /usr/local/openresty/nginx/logs/error.log

# Copy nginx configuration files
COPY Dockerfiles/openresty/conf/nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
COPY Dockerfiles/openresty/conf.d/ /etc/nginx/conf.d/

# Set proper permissions for conf.d (required for Lua config generation)
RUN chmod 777 /etc/nginx/conf.d

EXPOSE 80

CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]
