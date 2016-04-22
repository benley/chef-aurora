# Do some stuff RHEL specific
include_recipe 'java' if node['aurora']['install_java']

# Add Aurora repository
include_recipe "aurora::_rhel_repo"

# Aurora prerequisite
include_recipe 'mesos::install'

# Install aurora-scheduler package
remote_file 'aurora-scheduler-0.12.0-1.el7.centos.aurora.x86_64.rpm' do
  source 'https://bintray.com/artifact/download/apache/aurora/centos-7/aurora-scheduler-0.12.0-1.el7.centos.aurora.x86_64.rpm'
  mode '0755'
end
yum_package 'aurora-scheduler-0.12.0-1' do
  source 'aurora-scheduler-0.12.0-1.el7.centos.aurora.x86_64.rpm'
  action :install
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
