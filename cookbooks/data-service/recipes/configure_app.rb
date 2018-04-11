#
# Cookbook Name:: data-service
# Recipe:: configure_app
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

cookbook_file '/etc/settings.cfg' do
    mode '0644'
    source 'settings.cfg'
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

# Create the flask doc if it is set
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
    environment(
        'PREFIX_PATH' => node['data-service_data-service']['dir']
      )
    command 'pip install --install-option="--prefix=$PREFIX_PATH" /tmp/deploy/craft-data-services-flask.zip'
end

# stop datadog-agent
service 'datadog-agent' do
  supports status: true, restart: true, reload: true
  action [ :stop ]
end

# start the app
# TODO needs to be upstart
execute 'start flask app' do
    environment(
        'FLASK_APP' => node['data-service_data-service']['appName'],
        'INDECISION_SETTINGS' => '/etc/settings.cfg'
      )
    cwd node['data-service_data-service']['dir']
    command 'flask run --host=0.0.0.0 &'
end

# start datadog-agent
service 'datadog-agent' do
  supports status: true, restart: true, reload: true
  action [ :start ]
end

# execute 'Mark app online 10 retries with 10 sec delay' do
#     command "curl -I http://localhost:5000/health | grep 200"
#     retries 10
#     retry_delay 10
#     action :run
# end
