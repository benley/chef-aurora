# Add Aurora repository
include_recipe 'mesos::repo'
include_recipe 'aurora::repo'

# Install Aurora
package 'aurora-scheduler'

# Include generic scheduler configuration
include_recipe 'aurora::_common_scheduler'
