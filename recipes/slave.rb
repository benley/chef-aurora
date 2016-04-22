# Include the appropriate recipe
#
include_recipe "aurora::_#{node['platform_family']}_slave"
