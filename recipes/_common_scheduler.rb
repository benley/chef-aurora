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
    (! ::File.exist? '/var/lib/aurora/scheduler/db/CURRENT') &&
      node['aurora']['scheduler']['autoinit_db'].to_s.casecmp('true').zero?
  end
  command 'mesos-log initialize --path=/var/lib/aurora/scheduler/db'
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
