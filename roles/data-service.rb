name 'data-service'
description 'data-service'

INSTANCE_ID = `curl -s http://169.254.169.254/latest/meta-data/instance-id`
APPD_NODE_NAME = "#{`hostname`.chomp}-#{INSTANCE_ID}"

# Add attributes here
default_attributes({

    },)


run_list 'recipe[craft_shared::install_monitoring_scripts]',
         'recipe[data-service::configure_app]'
