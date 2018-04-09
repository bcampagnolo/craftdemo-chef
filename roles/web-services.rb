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
        'upstream' => false,
        'sslCert' => '/etc/ssl/certs/nginx-selfsigned.crt',
        'sslKey' => '/etc/ssl/certs/nginx-selfsigned.key',

        "server" => {
            "healthcheck" => {
                "access_log" => "",
                "locations" => [
                    {
                        "path" => "/health",
                        "options" => [
                            "proxy_pass http://localhost:8080;"
                        ]
                    }
                ]
            }
        }
    }

})

run_list  'recipe[dream_shared::install_monitoring_scripts]',
          'recipe[nginx::install]