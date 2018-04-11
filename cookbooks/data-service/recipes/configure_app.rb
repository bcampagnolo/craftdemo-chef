#
# Cookbook Name:: data-service
# Recipe:: configure_app
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# stop datadog-agent
service 'datadog-agent stop' do
  action :stop
  stop_command '/bin/systemctl stop datadog-agent.service'
end

cookbook_file '/etc/settings.cfg' do
  mode '0644'
  source 'settings.cfg'
  owner 'root'
  group 'root'
  backup false
end

cookbook_file '/etc/supervisord.conf' do
  mode '0644'
  source 'supervisord.conf'
  owner 'root'
  group 'root'
  backup false
end

# Create the flask doc if it is set
if node['data-service_data-service']['dir'] != ''
  directory node['data-service_data-service']['dir'] do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
    recursive true
  end
end

# Create the flask log if it is set
if node['data-service_data-service']['logDir'] != ''
  directory node['data-service_data-service']['logDir'] do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
    recursive true
  end
end

# install the app 
execute 'install flask app' do
  command 'pip install /tmp/deploy/indecision.zip'
end

execute 'install-supervisor' do
  command 'pip install supervisor'
end

# start the app
# TODO needs to be upstart
execute 'start flask app' do
  command 'supervisord -c /etc/supervisord.conf'
end

# execute 'Mark app online 10 retries with 10 sec delay' do
#     command "curl -I http://localhost:5000/health | grep 200"
#     retries 10
#     retry_delay 10
#     action :run
# end

# start datadog-agent
service 'datadog-agent start' do
  action :start
  start_command '/bin/systemctl start datadog-agent.service'
end
