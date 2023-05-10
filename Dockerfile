FROM bitnami/wordpress-nginx

## Change user to perform privileged actions
USER 0
## Install 'vim'
RUN install_packages vim
## Revert to the original non-root user
USER 1001

## Modify 'worker_connections' on NGINX config file to '1024'
RUN sed -i -r "s#(\s+worker_connections\s+)[0-9]+;#\11024;#" /opt/bitnami/nginx/conf/nginx.conf
RUN sed -i -r "s#(\s+client_max_body_size\s+)[0-9].+;#\11000M;#" /opt/bitnami/nginx/conf/nginx.conf

## Modify the ports used by NGINX by default
# It is also possible to change these environment variables at runtime
# ENV NGINX_HTTP_PORT_NUMBER=8080
# ENV NGINX_HTTPS_PORT_NUMBER=8443
EXPOSE 8080 8443
