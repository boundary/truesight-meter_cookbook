name             'truesight-meter'
maintainer       'BMC Software'
maintainer_email 'truesightops@bmc.com'
license          'Apache 2.0'
description      'Installs/Configures truesight-meter'
long_description 'Installs/Configures truesight-meter'
version          '0.1.0'

%w{ ubuntu debian rhel centos amazon scientific }.each do |os|
  supports os
end

depends 'apt'
depends 'yum', '>= 3.2.0'