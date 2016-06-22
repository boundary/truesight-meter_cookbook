#
# Author:: Zachary Schneider (<truesightops@bmc.com>)
# Cookbook Name:: truesight-meter
# Attributes:: default
#
# Copyright 2016, BMC Software
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# your API Key
default['truesight_meter']['token'] = ''

default['truesight_meter']['hostname'] = node['fqdn']
default['truesight_meter']['tags'] = [node.chef_environment]

# discover tags from various providers that publish node attributes
default['truesight_meter']['discover_tags'] = true

# install or upgrade
# if you opt for upgrade you may notice small metric gaps
# following a chef run that upgrades the meter package
default['truesight_meter']['install_type'] = 'upgrade'

# explicity list interfaces to monitor (you can leave this empty)
default['truesight_meter']['interfaces'] = []

# periodic stats on pcap interface
default['truesight_meter']['pcap_stats'] = 0

# promisc mode
default['truesight_meter']['pcap_promisc'] = 0

# STUN support for public IP detection
default['truesight_meter']['enable_stun'] = 0

#
# you should not have to modify these values
#
default['truesight_meter']['api']['hostname'] = 'api.truesight.bmc.com'
default['truesight_meter']['tls']['skip_validation'] = false
