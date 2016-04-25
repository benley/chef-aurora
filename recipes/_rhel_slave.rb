# Add (Mesos & Aurora) required repositories
include_recipe 'mesos::repo'
include_recipe 'aurora::repo'


# RHEL specific stuff

# Install aurora-executor package
yum_package 'aurora-executor' do
  source "aurora-executor-0.12.0-1.el7.centos.aurora.x86_64.rpm"
  action :install
end

# Start thermos observer
service 'thermos-observer' do
  action [:enable, :start]
end
