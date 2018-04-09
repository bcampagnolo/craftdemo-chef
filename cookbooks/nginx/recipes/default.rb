#
# Cookbook Name:: nginx 
# Recipe:: default
#
#

include_recipe "nginx::uninstall"

include_recipe "nginx::install"
