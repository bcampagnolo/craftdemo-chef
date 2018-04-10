#
# Cookbook Name:: craft_shared
# Recipe:: install_monitoring_scripts
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

directory File.dirname(node[:craft_shared][:monitoring_script]) do
    action :create
    recursive true
end

directory File.dirname(node[:craft_shared][:monitoring_log]) do
    mode 0774
    action :create
    recursive true
end

template node[:craft_shared][:monitoring_script] do
    source node[:craft_shared][:monitoring_template]
    mode 0774
    backup false
end

cron "run_monitoring_script" do
    minute node[:craft_shared][:monitoring_cron_minute]
    hour node[:craft_shared][:monitoring_cron_hour]
    day node[:craft_shared][:monitoring_cron_day]
    weekday node[:craft_shared][:monitoring_cron_weekday]
    month node[:craft_shared][:monitoring_cron_month]
    command "/bin/bash #{node[:craft_shared][:monitoring_script]} >/dev/null 2>&1"
end
