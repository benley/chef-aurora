# aurora cookbook

Chef cookbook for Apache Aurora

## Supported Platforms

Only tested on Ubuntu 14.04, with the Folsom Labs deb packages for Aurora. Should be easily adaptable to other Ubuntu and Debian releases.

## Attributes

There are a lot of attributes. Please read through [attributes/default.rb](attributes/default.rb) for the details.

## Usage

### aurora::scheduler

Make sure you set the cluster name, zookeeper endpoints, mesos master url, and any other important attributes.

Include `aurora` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[aurora::scheduler]"
  ]
}
```

### aurora::slave

Include aurora::slave in your mesos slave nodes run_list. You will most likely want to set some attrbibutes (as in, mesos slave attributes) for aurora to use.

For example, this might make sense for a cluster on AWS:

```ruby
default['mesos']['slave']['attributes']['host'] = node['hostname']
default['mesos']['slave']['attributes']['rack'] = node['ec2']['placement_availability_zone']
default['mesos']['slave']['attributes']['instance_id'] = node['ec2']['instance_id']
default['mesos']['slave']['attributes']['instance_type'] = node['ec2']['instance_type']
```

If you want to enable thermos service announcements to zookeeper, you can set some options **on the scheduler nodes**:

```ruby
default['aurora']['thermos'] = {
  announcer_enable: true,
  zk_announce_endpoints: 'zk.example.com:2181,zk2.example.com:2181',
  zk_announce_path: '/services'
}
```

## License and Authors

Author:: Benjamin Staffin (<ben@folsomlabs.com>)
