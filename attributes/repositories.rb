#
# Author:: Zachary Schneider (<truesightops@bmc.com>)
# Cookbook Name:: truesight-meter
# Attributes:: repositories
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

default['truesight_meter']['repositories']['apt']['url'] = 'https://apt.truesight.bmc.com/ubuntu/'
default['truesight_meter']['repositories']['apt']['key'] = 'https://apt.truesight.bmc.com/APT-GPG-KEY-Truesight'

default['truesight_meter']['repositories']['yum']['url'] = 'https://yum.truesight.bmc.com/centos/os'
default['truesight_meter']['repositories']['yum']['key'] = 'https://yum.truesight.bmc.com/RPM-GPG-KEY-Truesight'
