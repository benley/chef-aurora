# Start thermos observer
service 'thermos-observer' do
  service_name node['aurora']['services']['thermos_observer_name']
  action [:enable, :start]
end
