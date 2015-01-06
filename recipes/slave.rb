# encoding: utf-8
#
# Cookbook Name:: aurora
# Recipe:: slave
#
# Copyright (C) 2014 Folsom Labs
#

include_recipe 'aurora::apt_repo'

package 'aurora-mesos-slave'

template '/etc/default/aurora-thermos' do
  source 'aurora-thermos.default.erb'
  variables lazy { node['aurora']['thermos'] }
  owner 'root'
  group 'root'
  mode '00644'
  notifies :restart, 'service[aurora-thermos]'
end

service 'aurora-thermos' do
  action [:enable, :start]
  provider Chef::Provider::Service::Upstart
end