#
# Author:: Zachary Schneider (<truesightops@bmc.com>)
# Cookbook Name:: truesight-meter
# Library:: truesight_meter
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

module TrueSight
  module Meter

    CONF_DIR = '/etc/truesight'

    def get_meter(resource)
      meter_name = (resource.is_alt) ? "truesight-meter_#{resource.name}" : 'truesight-meter'
      cmd = Mixlib::ShellOut.new("truesight-meter --dump-meter-info -I #{meter_name}")
      cmd.run_command
      raise Exception.new("truesight meter status failed") if cmd.error?
      json = JSON.parse(cmd.stdout)
    end

    def meter_provisioned?(resource)
      meter = get_meter(resource)
      meter['status']['premium'] == 'ok'
    end

    # TODO This is transitional
    # Only checking a subset of values relevent to provisioning
    def meter_config_current?(resource)
      return false unless ::File.exists?("#{resource.conf_dir}/meter.conf")

      config = JSON.parse(::File.read("#{resource.conf_dir}/meter.conf"))
      

      return false unless 
        resource.token == config['api']['token']  and
        truesight_data('api')['hostname'] == config['api']['host'] 

      true        
    end

    def setup_conf_dir(resource)
      ::Dir.mkdir(resource.conf_dir) unless ::File.directory?(resource.conf_dir)
      ::FileUtils.cp "#{TrueSight::Meter::CONF_DIR}/ca.pem", "#{resource.conf_dir}/" unless ::File.exists?("#{resource.conf_dir}/ca.pem")
    end

    def remove_conf_dir(resource)
      if ::File.directory?(resource.conf_dir) && resource.conf_dir != TrueSight::Meter::CONF_DIR && resource.conf_dir.include?(TrueSight::Meter::CONF_DIR)
        ::FileUtils.rm Dir.glob "#{resource.conf_dir}/*"
        ::Dir.rmdir resource.conf_dir
      end
    end

    def build_command(resource, action)
      command = [
        "truesight-meter -l #{action.to_s}",
        "-P https://#{truesight_data('api')['hostname']}",
        "-p #{resource.token}",
        "-b #{resource.conf_dir}",
        "-n tls://#{truesight_data('collector')['hostname']}:#{truesight_data('collector')['port']}",
        "--nodename #{resource.node_name}"
      ]

      if action == :create
        command.push "--tag #{resource.tags.join(',')}" unless resource.tags.empty?

        if truesight_data_data('enable_stun') == 1
          command.push "--enable-stun"
        end

        if truesight_data_data('tls')['skip_validation'] == true
          command.push "--tls-skip-validation"
        end
      end

      return command.join(' ')
    end

    def run_command(command)
      Chef::Log.info(command)

      cmd = Mixlib::ShellOut.new(command)
      cmd.run_command
      cmd.error!
    end
  end
end
