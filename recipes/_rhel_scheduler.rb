# Add (Mesos & Aurora) required repositories
include_recipe 'mesos::repo'
include_recipe 'aurora::repo'


# RHEL specific

# Install aurora-scheduler package
yum_package 'aurora-scheduler-0.12.0-1' do
  source 'aurora-scheduler-0.12.0-1.el7.centos.aurora.x86_64.rpm'
end

# Include generic scheduler configuration
include_recipe "aurora::_common_scheduler"

# Write rhel specific configuration file
template 'aurora-scheduler-config' do
  source 'aurora-scheduler-config-rhel.erb'
  path '/etc/sysconfig/aurora'
  variables lazy { node['aurora']['scheduler'] }
  user 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[aurora-scheduler]'
end

service 'aurora-scheduler' do
  service_name 'aurora'
  action [:enable]
end
