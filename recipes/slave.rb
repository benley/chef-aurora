# encoding: utf-8
#
# Cookbook Name:: aurora
# Recipe:: slave
#
# Copyright (C) 2014 Folsom Labs
#

include_recipe 'aurora::apt_repo'

package 'aurora-executor'

template '/etc/default/thermos' do
  source 'thermos.default.erb'
  variables lazy { node['aurora']['thermos'] }
  owner 'root'
  group 'root'
  mode '00644'
  notifies :restart, 'service[thermos]'
end

service 'thermos' do
  action [:enable, :start]
  provider Chef::Provider::Service::Upstart
end
