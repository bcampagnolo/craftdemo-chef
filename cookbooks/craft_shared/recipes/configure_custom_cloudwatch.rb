#
# Cookbook Name:: craft_shared
# Recipe:: configure_custom_cloudwatch_
#

# Unless we restart the rsyslog service, the hostname in /var/log/messages will
# be the hostname of the instance the AMI was created from :(
service 'rsyslog' do
    supports restart: true
    action :restart
end

if platform_family?('rhel')
  pip_binary = '/usr/bin/pip'
else
  pip_binary = '/usr/local/bin/pip'
end

execute 'install-cloudwatchmon' do
  cwd Chef::Config[:file_cache_path]
  command <<-EOF
    pip install cloudwatchmon
    EOF
  only_if { File.exist?(pip_binary) }
end

cookbook_file '/root/cloudwatchmon.sh' do
  source 'cloudwatchmon.sh'
  owner 'root'
  group 'root'
  mode 0755
end

cron 'cloudwatchmon' do
  minute '*/5'
  command '/root/cloudwatchmon.sh'
end
