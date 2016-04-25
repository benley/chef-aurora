# Add (Mesos & Aurora) required repositories
include_recipe 'mesos::repo'
include_recipe 'aurora::repo'


# RHEL specific stuff

# Install aurora-executor package
package 'aurora-executor' do
  if node['aurora']['package']['rhel']['install_method'] == 'rpm'
    source 'aurora-executor-0.12.0-1.el7.centos.aurora.x86_64.rpm'
  end
end

# Start thermos observer
service 'thermos-observer' do
  action [:enable, :start]
end
