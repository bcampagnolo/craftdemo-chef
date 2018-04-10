#
# Cookbook Name:: nginx
# Recipe:: install
#
#

if platform?('redhat', 'centos', 'scientific', 'fedora', 'amazon')

  # Grab the RPM out of S3
  remote_file '/tmp/nginx.rpm' do
    source (node['nginx']['url']).to_s
    mode '0755'
  end

  # install rpm
  package 'Installing Nginx' do
    action :install
    source '/tmp/nginx.rpm'
    provider Chef::Provider::Package::Rpm
  end
  # Do not proceed with the remaining steps if the installation is not attempted
else
  raise "Platform #{node['platform']} is not supported by this cookbook. Exiting.."
end

# todo - move to credstash or secret cli / service
cookbook_file "#{node['nginx']['sslDir']}/nginx-selfsigned.crt" do
    mode '0644'
    source 'nginx-selfsigned.crt'
    owner 'root'
    group 'root'
end

# todo - move to credstash or secret cli / service
cookbook_file "#{node['nginx']['sslDir']}/nginx-selfsigned.key" do
  mode '0644'
  source 'nginx-selfsigned.key'
  owner 'root'
  group 'root'
end

# Create the docRoot if it is set
if node['nginx']['docRoot'] != ''
  directory node['nginx']['docRoot'] do
    owner 'nginx'
    group 'nginx'
    mode '0755'
    action :create
    recursive true
  end
end

file "#{node['nginx']['homeDir']}/conf.d/default.conf" do
  action :delete
end

template "#{node['nginx']['homeDir']}/nginx.conf" do
  mode '0644'
  source 'nginx.conf.erb'
  owner 'nginx'
  group 'nginx'
  backup false
end

cookbook_file "#{node['nginx']['homeDir']}/conf.d/http-https-redirect.conf" do
    mode '0644'
    source 'http-https-redirect.conf'
    owner 'nginx'
    group 'nginx'
    backup false
end

cookbook_file "#{node['nginx']['homeDir']}/proxy.conf" do
  mode '0644'
  source 'proxy.conf'
  owner 'nginx'
  group 'nginx'
end

cookbook_file "#{node['nginx']['homeDir']}/conf.d/ssl-proxy-protocol.conf" do
  mode '0644'
  source 'ssl-proxy-protocol.conf'
  owner 'nginx'
  group 'nginx'
  backup false
end

service 'nginx' do
  supports status: true, restart: false, reload: true
  action [ :enable, :start ]
end
