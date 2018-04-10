# Set chef homedir
chef_home_dir = File.expand_path('./')

# Download temporary files to /tmp
file_cache_path '/tmp'

# Set path to config
cookbook_path [ File.join(chef_home_dir, 'berks-cookbooks')]
role_path File.join(chef_home_dir, 'roles')

# Chef log file
log_location '/var/log/chef/chef.log'

# # Proxy settings
# http_proxy ENV['http_proxy']
# https_proxy ENV['https_proxy']
# no_proxy ENV['no_proxy']
