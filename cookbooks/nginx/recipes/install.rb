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

cookbook_file "#{node['nginx']['sslDir']}/nginx-selfsigned.crt" do
    mode '0644'
    source 'nginx-selfsigned.crt'
    owner 'root'
    group 'root'
end

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

template "#{node['nginx']['homeDir']}/nginx.conf" do
  mode '0644'
  source 'nginx.conf.erb'
  owner 'root'
  group 'root'
  backup false
end

template "#{node['nginx']['homeDir']}/conf.d/default.conf" do
    mode '0644'
    source 'default.conf.erb'
    owner 'root'
    group 'root'
    backup false
end

cookbook_file "#{node['nginx']['homeDir']}/proxy.conf" do
  mode '0644'
  source 'proxy.conf'
  owner 'root'
  group 'root'
end

service 'nginx' do
  supports status: true, restart: false, reload: true
  action [:enable]
end
