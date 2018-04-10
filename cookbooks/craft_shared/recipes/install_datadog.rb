#
# Cookbook Name:: craft_shared
# Recipe:: install_datadog
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

execute 'server_agent_install' do
    command 'DD_API_KEY=28e89ddbe65c48f8de7ac7e59a175c86 bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/dd-agent/master/packaging/datadog-agent/source/install_agent.sh)"'
end
