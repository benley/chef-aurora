include_recipe 'aurora::repo'

# Install aurora-executor package
package 'aurora-executor'

include_recipe 'aurora::_common_slave'
