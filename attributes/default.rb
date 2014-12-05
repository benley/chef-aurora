# encoding: utf-8

default['aurora']['thermos'] = {
  zk_announce_endpoints: 'localhost:2181',
  zk_announce_path: '/aurora/svc'
}

default['aurora']['scheduler'] = {
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

  # URL to thermos executor script, or path on the slaves
  thermos_executor: '/usr/share/aurora/bin/thermos_executor.sh',

  # URL or path to the garbage collection executor
  gc_executor: '/usr/share/aurora/bin/gc_executor.pex',

  log_level: 'INFO',

  extra_scheduler_args: '-enable_beta_updater=true'
}
