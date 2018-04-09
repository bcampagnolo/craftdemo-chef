#
# Cookbook Name:: nginx
# Recipe:: 1.12.2-1.el7_4
#
#
#
node.set['nginx']['url'] = 'https://s3-us-west-2.amazonaws.com/496911069803-us-west-2-artifacts/rpm/nginx-1.12.2-1.el7_4.ngx.x86_64.rpm'

include_recipe 'nginx::default'
