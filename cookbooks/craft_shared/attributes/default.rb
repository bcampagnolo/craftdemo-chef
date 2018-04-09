# Cookbook Name:: craft_shared
# Attributes:: default
#

default['craft_shared']['monitoring_template'] = 'monitor-node.sh.erb'
default['craft_shared']['monitoring_script'] = '/opt/bin/monitor-node.sh'
default['craft_shared']['monitoring_log'] = '/app/monitor/logs/monitor.log'
default['craft_shared']['monitoring_cron_minute'] = '*/1'
default['craft_shared']['monitoring_cron_hour'] = '*'
default['craft_shared']['monitoring_cron_day'] = '*'
default['craft_shared']['monitoring_cron_weekday'] = '*'
default['craft_shared']['monitoring_cron_month'] = '*'

default['craft_shared']['ssl_dir'] = "/etc/ssl/certs"
