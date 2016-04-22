# encoding: utf-8
#
# Cookbook Name:: aurora
# Recipe:: _rhel_repo
#

remote_file 'mesosphere-el-repo-7-1.noarch.rpm' do
  source 'http://repos.mesosphere.io/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm'
  mode '0755'
end
yum_package 'mesosphere-el-repo-7.1' do
  source 'mesosphere-el-repo-7-1.noarch.rpm'
  action :install
end
