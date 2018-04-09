#
# Cookbook Name:: nginx 
# Recipe:: uninstall
#
#

# Uninstall only if nginx exists 
if File.exists?("#{node['nginx']['homeDir']}")
	# Stop nginx if possibe # 1 when nginx process was not running for some reason
	service 'nginx' do
    	action [:stop, :disable]
 	end

 	# Remove our limits.conf changes
	if File.exists?("/etc/security/limits.d.orig")
		execute "delete our custom limits.d folder" do
			command "sudo rm -rf limits.d"
			cwd "/etc/security"
			action :run
		end

		execute "put original limits.d folder back" do
			command "sudo mv limits.d.orig limits.d"
			cwd "/etc/security"
			action :run
		end
	end

	# Remove the sym links 
	link "/var/cache/nginx" do
		action :delete
		only_if do File.symlink?("/var/cache/nginx") end
	end

	link "/var/log/nginx" do
		action :delete
		only_if do File.symlink?("/var/log/nginx") end
	end

	# Remove the /app/nginx
	directory "/app/nginx/cache" do
	  action :delete
	  recursive true
	  only_if do File.exists?("/app/nginx/cache") end
	end

	# Create app nginx log dir 
	directory "/app/nginx/logs" do
	  action :delete
	  recursive true
	  only_if do File.exists?("/app/nginx/logs") end
	end

  #Remove Nginx maintenance folder
  directory "#{node['nginx']['maintenance']['location']}" do
	  action :delete
	  recursive true
	  only_if do File.exists?("#{node['nginx']['maintenance']['location']}") end
	end

	# Remove the package 
	package "nginx" do
	    action :remove
	    provider Chef::Provider::Package::Rpm
	 end

	 # The above uninstall backs up the nginx.conf and proxy.conf since they were modified after rpm install
	 # cleaning them up 
	 directory "#{node['nginx']['homeDir']}" do
	 	action :delete
	  	recursive true
	 end
end
