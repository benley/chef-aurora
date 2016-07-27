# Add (Mesos & Aurora) required repositories
include_recipe 'mesos::repo' if node['mesos']['repo']
include_recipe 'aurora::repo'

# Install aurora-scheduler package
package 'aurora-scheduler' do
  if node['aurora']['package']['rhel']['install_method'] == 'rpm'
    source "aurora-scheduler-#{node['aurora']['version']}.el7.centos.aurora.x86_64.rpm"
  end
  version node['aurora']['version']
end

# Include generic scheduler configuration
include_recipe 'aurora::_common_scheduler'
