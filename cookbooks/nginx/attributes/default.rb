#
# Cookbook Name:: nginx
# Attributes:: default
#
default['nginx']['url'] = "https://s3-us-west-2.amazonaws.com/496911069803-us-west-2-artifacts/rpm/nginx-1.12.2-1.el7_4.ngx.x86_64.rpm"
default['nginx']['homeDir'] = "/etc/nginx"
default['nginx']['docRoot'] = "/var/www"
default['nginx']['indexFile'] = "index.html"
default['nginx']['logDir'] = "/var/log/nginx"
default['nginx']['logType'] = "main"

default['nginx']['protocol_support_443'] = "ssl"

default['nginx']['listenPort'] = "80" #http port

## SSL Config
default['nginx']['sslCert'] = "nginx-selfsigned.crt"
default['nginx']['sslKey'] = "nginx-selfsigned.key"
default['nginx']['sslDir'] = "/etc/ssl/certs/"

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
default['nginx']['server']['ssl_proxy_protocol']['set_real_ip_from'] = "10.30.0.0/16"
