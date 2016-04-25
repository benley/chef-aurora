# Add Aurora repository
include_recipe 'mesos::repo'
include_recipe 'aurora::repo'


# Debian specific stuff

# Install Aurora
package 'aurora-scheduler'

# Include generic scheduler configuration
include_recipe "aurora::_common_scheduler"

# Write debian specific configuration file
template 'aurora-scheduler-config' do
  source 'aurora-scheduler-config-debian.erb'
  path '/etc/default/aurora-scheduler'
  variables lazy { node['aurora']['scheduler'] }
  user 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[aurora-scheduler]'
end

service 'aurora-scheduler' do
  action [:enable]
end
