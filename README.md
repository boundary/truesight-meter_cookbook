#### The truesight-meter Cookbook

This cookbook is used to install and configure (via the TrueSight API) the TrueSight meter. To get things running, set your TrueSight account's API key in the attributes/default.rb and add truesight-meter::default to your host's run_list.

#### Dependencies

Dependencies and their requisite versions, when necessary, are specified in metadata.rb.

#### Configuration Options

##### API Keys

Setup your API keys in attributes/api.rb for Boundary Enterprise

TrueSight Pulse

```ruby
default['truesight_meter']['token'] = 'api_token'
```

##### TrueSight Meter Tags

By default, the cookbook sends the chef_environment as a meter tag to the Boundary service.

If your host is in EC2 or you are using Opsworks, it adds a few tags specific to those environments.

You can set more tags by manipulating the node['truesight_meter']['tags'] attribute.

##### Interfaces

The meter defaults to monitoring all interfaces. You can change this with the node['truesight_meter']['interfaces'] array:

```ruby
node['truesight_meter']['interfaces'] = [ 'eth0', 'eth2' ]
```

##### Hostname

The TrueSight meter defaults to using `node['fqdn']` as the hostname. You can override this by setting `node['truesight_meter']['hostname']` with a higher precedence then default.


#### EC2

This cookbook includes automatic detection and tagging of your meter with various EC2 attributes such as security group and instance type.

#### OpsWorks

If you are using OpsWorks this cookbook should work out of the box (with the above dependencies). This cookbook also includes automatic detection and tagging of your meter with layers, stack name and applications if any exist.
