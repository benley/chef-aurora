include_recipe 'aurora::repo'

# Debian specific stuff

# Install aurora-executor package
package 'aurora-executor'

# Configure Thermos observer
template '/etc/default/thermos' do
  source 'thermos-observer-debian.erb'
  variables node['aurora']['thermos_observer']
  owner 'root'
  group 'root'
  mode '00644'
  notifies :restart, 'service[thermos-observer]'
end

# Start thermos observer
service 'thermos-observer' do
  service_name 'thermos'
  action [:enable, :start]
end
