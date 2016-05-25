# Configure Thermos observer (Debian)
template 'thermos-observer-config' do
  source "thermos-observer-#{node['platform_family']}.erb"
  path node['aurora']['config_files']['thermos_observer']
  variables node['aurora']
  owner 'root'
  group 'root'
  mode '00644'
  notifies :restart, 'service[thermos-observer]'
end

# Start thermos observer
service 'thermos-observer' do
  service_name node['aurora']['services']['thermos_observer']
  action [:enable, :start]
end
