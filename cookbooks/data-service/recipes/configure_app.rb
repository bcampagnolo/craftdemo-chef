#
# Cookbook Name:: data-service
# Recipe:: configure_app
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

remote_file File.join(node['upstart_java']['base_dir'],
                      node['upstart_java']['app_name'],
                      node['upstart_java']['server_file']) do
    source "file:///tmp/deploy/#{node['upstart_java']['server_file']}"
    owner node['upstart_java']['user']
    group node['upstart_java']['group']
    mode '0755'
end

execute 'permissions fix' do
  command 'chmod -R 755 /app'
  action :run
end

service node['upstart_java']['app_name'] do
    supports status: true
    provider Chef::Provider::Service::Upstart
    action [:enable, :start]
end

execute 'Mark app online 10 retries with 10 sec delay' do
    command "curl -I http://localhost:5000/health | grep 200"
    retries 10
    retry_delay 10
    action :run
end
