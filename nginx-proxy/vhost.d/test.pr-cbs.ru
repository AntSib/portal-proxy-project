# Individual logs for this domain
access_log /var/log/nginx/pr-cbs.ru_access.log main;
error_log  /var/log/nginx/pr-cbs.ru_error.log warn;

# TLS parameters (legacy) highly recommend to switch to TLSv1.3
ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
ssl_ciphers HIGH:!aNULL:!MD5;
ssl_prefer_server_ciphers on;

add_header Strict-Transport-Security "max-age=15768000";

resolver 77.88.8.8 77.88.8.1;
resolver_timeout 5s;

location / {

    proxy_pass https://${PR_CBS_UPSTREAM_IP}:443;

    proxy_ssl_server_name on;
    proxy_ssl_verify off;

    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header Host $host;
    proxy_set_header X-Forwarded-Proto https;

    proxy_connect_timeout 240;
    proxy_send_timeout 240;
    proxy_read_timeout 240;

    proxy_redirect off;
}