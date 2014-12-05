# encoding: utf-8
#
# Cookbook Name:: aurora
# Recipe:: scheduler
#
# Copyright (C) 2014 Folsom Labs
#
# All rights reserved - Do Not Redistribute
#

package 'aurora-scheduler'

service 'aurora-scheduler' do
  action :nothing
end

execute 'initialize aurora replicated log' do
  not_if { ::File.exist? '/var/lib/aurora/scheduler/db/CURRENT' }
  command 'mesos-log initialize --path=/var/lib/aurora/scheduler/db'
  notifies :restart, 'service[aurora-scheduler]'
end

template '/etc/default/aurora-scheduler' do
  source 'aurora-scheduler.default.erb'
  variables node['aurora']['scheduler']
  user 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[aurora-scheduler]'
end
