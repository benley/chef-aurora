# encoding: utf-8
#
# Cookbook Name:: aurora
# Recipe:: apt_repo
#
# Copyright (C) 2014 Folsom Labs

apt_repository 'aurora' do
  uri 'http://apt.folsomlabs.com/aurora'
  distribution node['lsb']['codename']
  components ['main']
  arch 'amd64'
  keyserver 'keyserver.ubuntu.com'
  key '21E1FA28'
  only_if { node['aurora']['use_folsomlabs_apt_repo'] }
end
