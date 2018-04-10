name 'web-services'
description 'web-services'

INSTANCE_ID = `curl -s http://169.254.169.254/latest/meta-data/instance-id`
APPD_NODE_NAME = "#{`hostname`.chomp}-#{INSTANCE_ID}"

default_attributes({

    'nginx' => {
        'proxybuffer' => {
            'size' => '128k'
        },
        'healthCheck' => {
            'uri' => '/health'
        },
        'upstream' => true,
        'sslCert' => 'nginx-selfsigned.crt',
        'sslKey' => 'nginx-selfsigned.key',

        "server" => {
            "healthcheck" => {
                "access_log" => "",
                "locations" => [
                    {
                        "path" => "/health",
                        "options" => [
                            "proxy_pass http://app.craftdemodata.com:5000/;"
                        ]
                    }
                ]
            }
        }
    }

})

run_list 'recipe[craft_shared::install_monitoring_scripts]',
         'recipe[nginx::1.12.2-1.el7_4]'
