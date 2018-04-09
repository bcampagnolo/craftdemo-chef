# Cookbook Name:: data-service
# Attributes:: default
#
# region = us-west-2

default['craftdemo_appname'] = 'dh-data-service-web'
default['craftdemo_role'] = 'web'
default['craftdemo_env'] = ''
default['craftdemo_region'] = 'us-west-2'

default['craftdemo_data-service']['web']['index_path'] = '/app/nginx/docroot'
default['craftdemo_data-service']['web']['index_file'] = 'index.html'


