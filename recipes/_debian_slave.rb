# Do some stuff Debian specific

include_recipe 'aurora::_debian_repo'

# Install aurora-executor package
package 'aurora-executor'

# Configure Thermos
template '/etc/default/thermos' do
  source 'thermos.default.erb'
  variables lazy { node['aurora']['thermos'] }
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
