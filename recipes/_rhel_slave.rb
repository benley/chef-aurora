# Add (Mesos & Aurora) required repositories
include_recipe 'mesos::repo'
include_recipe 'aurora::repo'

# RHEL specific stuff

# Install aurora-executor package
package 'aurora-executor' do
  if node['aurora']['package']['rhel']['install_method'] == 'rpm'
    source "aurora-executor-#{node['aurora']['version']}.el7.centos.aurora.x86_64.rpm"
  end
  version node['aurora']['version']
end

# Start thermos observer
service 'thermos-observer' do
  action [:enable, :start]
end
