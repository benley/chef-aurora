# encoding: utf-8
#
# Cookbook Name:: aurora
# Recipe:: scheduler
#
# Copyright (C) 2014 Folsom Labs
#

include_recipe 'java' if node['aurora']['install_java']

directory '/var/lib/aurora/scheduler' do
  action :create
  recursive true
  owner 'aurora'
  group 'aurora'
  mode '0750'
end

directory '/var/lib/aurora/scheduler/db' do
  action :create
  recursive true
  owner 'aurora'
  group 'aurora'
  mode '0750'
end

execute 'initialize aurora replicated log' do
  only_if do
    # Warning: this test doesn't work as the file is created
    # 'unitialized' by aurora at startup
    (! ::File.exist? '/var/lib/aurora/scheduler/db/CURRENT') &&
      node['aurora']['scheduler']['autoinit_db']
  end
  command 'sudo -u aurora mesos-log initialize --path=/var/lib/aurora/scheduler/db'
  notifies :restart, 'service[aurora-scheduler]'
end

ruby_block 'set thermos_executor flags' do
  block do
    node.default['aurora']['scheduler']['app_config']['thermos_executor_flags'] =
      if node['aurora']['thermos']['announcer_enable']
        [
          '--announcer-enable',
          "--announcer-ensemble=#{node['aurora']['thermos']['zk_announce_endpoints']}",
          "--announcer-serverset-path=#{node['aurora']['thermos']['zk_announce_path']}"
        ].join(' ')
      else
        ''
      end
  end
end

# Write Mesos master credentials if required
template node['aurora']['scheduler']['app_config']['framework_authentication_file'] do
  source 'aurora-mesos-creds.erb'
  variables node['aurora']['scheduler']
  user 'aurora'
  group 'aurora'
  mode '0600'
  notifies :restart, 'service[aurora-scheduler]'
end if node['aurora']['scheduler']['mesos_creds'] and node['aurora']['scheduler']['app_config']['framework_authentication_file']
