# encoding: utf-8
#
# Cookbook Name:: aurora
# Recipe:: scheduler
#
# Copyright (C) 2014 Folsom Labs
#

node.default['java']['jdk_version'] = 7
include_recipe 'java' if node['aurora']['install_java']
include_recipe 'aurora::apt_repo'
include_recipe 'mesos::install'

package 'aurora-scheduler'

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
      node['aurora']['scheduler']['autoinit_db'].to_s.downcase == 'true'
  end
  command 'mesos-log initialize --path=/var/lib/aurora/scheduler/db'
  notifies :restart, 'service[aurora-scheduler]'
end

template '/etc/default/aurora-scheduler' do
  source 'aurora-scheduler.default.erb'
  variables lazy { node['aurora']['scheduler'] }
  user 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[aurora-scheduler]'
end

service 'aurora-scheduler' do
  action [:enable]
  provider Chef::Provider::Service::Upstart
end
