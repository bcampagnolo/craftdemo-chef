#
# Cookbook Name:: dream_shared
# Recipe:: install_monitoring_scripts
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

directory File.dirname(node[:dream_shared][:monitoring_script]) do
    action :create
    recursive true
end

directory File.dirname(node[:dream_shared][:monitoring_log]) do
    mode 0774
    action :create
    recursive true
end

template node[:dream_shared][:monitoring_script] do
    source node[:dream_shared][:monitoring_template]
    mode 0774
    backup false
end

cron "run_monitoring_script" do
    minute node[:dream_shared][:monitoring_cron_minute]
    hour node[:dream_shared][:monitoring_cron_hour]
    day node[:dream_shared][:monitoring_cron_day]
    weekday node[:dream_shared][:monitoring_cron_weekday]
    month node[:dream_shared][:monitoring_cron_month]
    command "/bin/bash #{node[:dream_shared][:monitoring_script]} >/dev/null 2>&1"
end