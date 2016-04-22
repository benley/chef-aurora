# Do some stuff Debian specific
include_recipe 'java' if node['aurora']['install_java']

# Add Aurora repository
include_recipe "aurora::_debian_repo"

# Install Aurora
include_recipe 'mesos::install'
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
  service_name 'aurora-scheduler'
  action [:enable]
end
