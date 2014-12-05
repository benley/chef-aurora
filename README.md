# aurora cookbook

Chef cookbook for Apache Aurora

## Supported Platforms

Only tested on Ubuntu 14.04, with the Folsom Labs deb packages for Aurora. Should be easily adaptable to other Ubuntu and Debian releases.

## Attributes

There are a lot of attributes. Please read through [attributes/default.md](attributes/default.md) for the details.

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

## License and Authors

Author:: Benjamin Staffin (<ben@folsomlabs.com>)
