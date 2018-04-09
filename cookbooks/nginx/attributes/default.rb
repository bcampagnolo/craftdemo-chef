#
# Cookbook Name:: nginx
# Attributes:: default
#

default['nginx']['url'] = "https://s3-us-west-2.amazonaws.com/496911069803-us-west-2-artifacts/rpm/nginx-1.12.2-1.el7_4.ngx.x86_64.rpm"
default['nginx']['homeDir'] = "/etc/nginx"
default['nginx']['docRoot'] = "/var/www"
default['nginx']['indexFile'] = "index.html"
default['nginx']['errorPage01'] = ""
default['nginx']['logDir'] = "/var/log/nginx"
default['nginx']['proxyPass'] = Array.new

default['nginx']['protocol_support_443'] = "ssl"

default['nginx']['proxy_protocol_support_443'] = "default_server ssl http2 proxy_protocol"

default['nginx']['listenPort'] = "80" #http port

## SSL Config
default['nginx']['sslCert'] = "/etc/ssl/certs/nginx-selfsigned.crt"
default['nginx']['sslKey'] = "/etc/ssl/certs/nginx-selfsigned.key"
default['nginx']['sslProtocols'] = "TLSv1.1 TLSv1.2"
default['nginx']['sslCiphers'] = "ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:DHE-RSA-AES128-GCM-SHA256:DHE-DSS-AES128-GCM-SHA256:kEDH+AESGCM:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDHE-ECDSA-AES128-SHA:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-ECDSA-AES256-SHA:DHE-RSA-AES128-SHA256:DHE-RSA-AES128-SHA:DHE-DSS-AES128-SHA256:DHE-RSA-AES256-SHA256:DHE-DSS-AES256-SHA:DHE-RSA-AES256-SHA:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!3DES:!MD5:!PSK"

## Proxy buffer settings
default['nginx']['proxybuffer']['size'] = '4k'
default['nginx']['proxybuffer']['count'] = 8
default['nginx']['server_tokens'] = 'off'

## Upstream Config
default['nginx']['upstreamLocation'] = "/"
default['nginx']['upstreamCount'] = node['cpu']['total']
default['nginx']['upstream'] = false
default['nginx']['upstreamProxyUri'] = ""

## HealthCheck settings for upstream
default['nginx']['healthCheck']['uri'] = "/health" #url that is hit after base url. so something like "/health/local

## http_to_https_server setting
default['nginx']['server']['http_to_https_redirect']['listen_port'] = "80"
default['nginx']['server']['http_to_https_redirect']['server_name'] = ".craftdemodata.com .elb.amazonaws.com"

default['nginx']['server']['ssl_proxy_protocol']['listen_port'] = "443"
default['nginx']['server']['ssl_proxy_protocol']['set_real_ip_from'] = "10.0.0.0/8"
