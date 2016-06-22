#
# Author:: Zachary Schneider (<truesightops@bmc.com>)
# Cookbook Name:: truesight-meter
# Library:: truesight_data
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

# TODO Having to do this just to do basic data access indirection involving
# node attrs and databag values is crap. Redo this, even if it mean accessing
# primitives, when there is more time.

class Chef
  module DSL::DataQuery
    def truesight_data(value, namespace='truesight_meter')
      from_data_bag(value, namespace) ||
      from_node_attr(value, namespace)
    end

    def truesight_data_merge(namespace='truesight_meter')
      databag, item = namespace.split('_')

      return node[namespace] unless item_in_data_bag?(databag, item)

      node[namespace].merge(data_bag_item(databag, item).to_hash)
    end

    private

    def from_data_bag(value, namespace)
      databag, item = namespace.split('_')

      return data_bag_item(databag, item)[value] if item_in_data_bag?(databag, item)

      nil
    end

    def from_node_attr(value, namespace)
      return node[namespace][value]
    end

    def item_in_data_bag?(databag, item)
      Chef::DataBag.list.include?(databag) && data_bag(databag).include?(item)
    end
  end
end
