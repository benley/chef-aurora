include_recipe 'mesos::repo'
include_recipe 'aurora::repo'

package 'aurora-tools' do
  if  node['platform_family'] == 'rhel' and
      node['aurora']['package']['rhel']['install_method'] == 'rpm'
    source "aurora-tools-#{node['aurora']['version']}.el7.centos.aurora.x86_64.rpm"
  end
  version node['aurora']['version']
end

directory '/etc/aurora'

file '/etc/aurora/clusters.json' do
  content Chef::JSONCompat.to_json_pretty(node['aurora']['client'])
  user 'root'
  group 'root'
  mode '0644'
end
