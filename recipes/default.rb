#
# Author:: Zachary Schneider (<truesightops@bmc.com>)
# Cookbook Name:: truesight-meter
# Recipe:: delete
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

include_recipe 'truesight-meter::dependencies'

package 'truesight-meter' do
  action boundary_data('install_type').to_sym
end

service 'truesight-meter' do
  ignore_failure true
end

truesight_meter "default" do
  notifies :restart, "service[truesight-meter]"
  ignore_failure true
end

template '/etc/default/truesight-meter' do
  source 'truesight-meter.default.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, "service[truesight-meter]"
  variables :boundary_meter => truesight_data_merge
end
