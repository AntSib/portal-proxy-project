FROM nginxproxy/nginx-proxy:alpine

COPY conf.d/*.conf /etc/nginx/conf.d/
COPY vhost.d/* /etc/nginx/vhost.d/

EXPOSE 80
EXPOSE 443
