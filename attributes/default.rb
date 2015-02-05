# encoding: utf-8

default['aurora']['thermos'] = {
  # Enable service announcements?
  announcer_enable: true,

  # zookeeper ensemble and base path for service announcements:
  zk_announce_endpoints: 'localhost:2181',
  zk_announce_path: '/aurora/svc'
}

default['aurora']['scheduler'] = {
  # Should Chef automatically initialize the replicated log?
  #
  # CAUTION: you only want to do this on the first scheduler node in a new
  #          cluster or you could lose *all* of your aurora state. RTFM!
  #
  autoinit_db: false,

  # libmesos logging verbosity
  libmesos_glog_v: '0',

  # Port used to register the framework with the mesos master
  libprocess_port: '8083',

  # Mesosphere debs put mesos libraries in /usr/local/lib
  java_opts: '-Djava.library.path=/usr/local/lib',

  cluster_name: 'example',
  http_port: '8081',

  # IMPORTANT: Set to (floor(NumberOfSchedulers/2) + 1)
  quorum_size: 1,

  # Comma-delimited list of host:ports
  zookeeper_endpoints: 'localhost:2181',

  mesos_master: 'zk://localhost:2181/mesos',

  zk_serverset: '/aurora/scheduler',
  zk_logdb: '/aurora/replicated-log',

  # URL to thermos executor (or wrapper script), or a path on the slaves
  thermos_executor: '/usr/share/aurora/bin/thermos_executor.pex',

  # A comma seperated list of additional resources to copy into the sandbox.
  # Note: if thermos_executor_path is not the thermos_executor.pex file itself,
  # this must include it.
  thermos_executor_resources: '',

  # URL or path to the garbage collection executor
  gc_executor: '/usr/share/aurora/bin/gc_executor.pex',

  log_level: 'INFO',

  extra_scheduler_args: '-enable_beta_updater=true'
}

# Set this to false if you don't want to add apt.folsomlabs.com/aurora to your
# system. You will need to have the aurora debs available by some other means
# in that case, presumably from your own repo.
default['aurora']['use_folsomlabs_apt_repo'] = true

# Is it cool for the scheduler recipe to install java?
default['aurora']['install_java'] = true
