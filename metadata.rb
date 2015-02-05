name             'aurora'
maintainer       'Benjamin Staffin'
maintainer_email 'ben@folsomlabs.com'
license          'Apache 2.0'
description      'Apache Aurora scheduler and slave nodes'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.10'

supports 'ubuntu'
depends 'apt'
depends 'java'
depends 'mesos'
