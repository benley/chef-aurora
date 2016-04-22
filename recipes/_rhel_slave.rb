# Do some stuff RHEL specific

include_recipe 'aurora::_rhel_repo'

# Install aurora-executor package
remote_file 'aurora-executor-0.12.0-1.el7.centos.aurora.x86_64.rpm' do
  source 'https://bintray.com/artifact/download/apache/aurora/centos-7/aurora-executor-0.12.0-1.el7.centos.aurora.x86_64.rpm'
  mode '0755'
end
yum_package 'aurora-executor-0.12.0-1' do
  source 'aurora-executor-0.12.0-1.el7.centos.aurora.x86_64.rpm'
  action :install
end

# Start thermos observer
service 'thermos-observer' do
  service_name 'thermos-observer'
  action [:enable, :start]
end
