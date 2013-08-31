# = Class: mongodb
#
# This is the main mongodb class
#
#
# == Parameters
#
# Module specific parameters
#
# [*use_10gen*]
#   Define if you want to use Official 10Gen repositories
#   to install packages. Default: false (OS default package is used)
#
# [*dependency_class*]
#   Name of the class containing dependencies required by the module
#
# [*bind_ip*]
#   Mongo server binding ip. Default: 127.0.0.1
#   Set to $::ipaddress for a networked server
#   Note that this parameter is used only if you explicitely define a
#   template file
#   To use the module's sample one: template => 'mongodb/mongodb.conf.erb'
#
# [*client_only*]
#   Set to true if you want to install only the client packages. Default: false.
#
# [*package_client*]
#   Name of the client package. Default: automatically detected.
#
# [*keyfile*]
#   Path of the keyfile. If set a keyfile is automatically generated in the
#   defined path. Default: '' (no file created)
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, mongodb class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $mongodb_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, mongodb main config file will have the param: source => $source
#   Can be defined also by the (top scope) variable $mongodb_source
#
# [*source_dir*]
#   If defined, the whole mongodb configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $mongodb_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the (top scope) variable $mongodb_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, mongodb main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $mongodb_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $mongodb_options
#
# [*service_autorestart*]
#   Automatically restarts the mongodb service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
#
# [*version*]
#   The package version, used in the ensure parameter of package type.
#   Default: present. Can be 'latest' or a specific version number.
#   Note that if the argument absent (see below) is set to true, the
#   package is removed, whatever the value of version parameter.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $mongodb_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $mongodb_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $mongodb_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $mongodb_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for mongodb checks
#   Can be defined also by the (top scope) variables $mongodb_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the (top scope) variables $mongodb_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $mongodb_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $mongodb_puppi_helper
#   and $puppi_helper
#
# [*firewall*]
#   Set to 'true' to enable firewalling of the services provided by the module
#   Can be defined also by the (top scope) variables $mongodb_firewall
#   and $firewall
#
# [*firewall_tool*]
#   Define which firewall tool(s) (ad defined in Example42 firewall module)
#   you want to use to open firewall for mongodb port(s)
#   Can be defined also by the (top scope) variables $mongodb_firewall_tool
#   and $firewall_tool
#
# [*firewall_src*]
#   Define which source ip/net allow for firewalling mongodb. Default: 0.0.0.0/0
#   Can be defined also by the (top scope) variables $mongodb_firewall_src
#   and $firewall_src
#
# [*firewall_dst*]
#   Define which destination ip to use for firewalling. Default: $ipaddress
#   Can be defined also by the (top scope) variables $mongodb_firewall_dst
#   and $firewall_dst
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $mongodb_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $mongodb_audit_only
#   and $audit_only
#
# [*noops*]
#   Set noop metaparameter to true for all the resources managed by the module.
#   Basically you can run a dryrun for this specific module if you set
#   this to true. Default: false
#
# Default class params - As defined in mongodb::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of mongodb package
#
# [*service*]
#   The name of mongodb service
#
# [*service_status*]
#   If the mongodb service init script supports status argument
#
# [*process*]
#   The name of mongodb process
#
# [*process_args*]
#   The name of mongodb arguments. Used by puppi and monitor.
#   Used only in case the mongodb process name is generic (java, ruby...)
#
# [*process_user*]
#   The name of the user mongodb runs with. Used by puppi and monitor.
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*pid_file*]
#   Path of pid file. Used by monitor
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
# [*port*]
#   The listening port, if any, of the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Note: This doesn't necessarily affect the service configuration file
#   Can be defined also by the (top scope) variable $mongodb_port
#
# [*protocol*]
#   The protocol used by the the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Can be defined also by the (top scope) variable $mongodb_protocol
#
#
# See README for usage patterns.
#
class mongodb (
  $use_10gen             = params_lookup( 'use_10gen' ),
  $dependency_class      = params_lookup( 'dependency_class' ),
  $bind_ip               = params_lookup( 'bind_ip' ),
  $client_only           = params_lookup( 'client_only' ),
  $package_client        = params_lookup( 'package_client' ),
  $keyfile               = params_lookup( 'keyfile' ),
  $my_class              = params_lookup( 'my_class' ),
  $source                = params_lookup( 'source' ),
  $source_dir            = params_lookup( 'source_dir' ),
  $source_dir_purge      = params_lookup( 'source_dir_purge' ),
  $template              = params_lookup( 'template' ),
  $service_autorestart   = params_lookup( 'service_autorestart' , 'global' ),
  $options               = params_lookup( 'options' ),
  $version               = params_lookup( 'version' ),
  $absent                = params_lookup( 'absent' ),
  $disable               = params_lookup( 'disable' ),
  $disableboot           = params_lookup( 'disableboot' ),
  $monitor               = params_lookup( 'monitor' , 'global' ),
  $monitor_tool          = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target        = params_lookup( 'monitor_target' , 'global' ),
  $puppi                 = params_lookup( 'puppi' , 'global' ),
  $puppi_helper          = params_lookup( 'puppi_helper' , 'global' ),
  $firewall              = params_lookup( 'firewall' , 'global' ),
  $firewall_tool         = params_lookup( 'firewall_tool' , 'global' ),
  $firewall_src          = params_lookup( 'firewall_src' , 'global' ),
  $firewall_dst          = params_lookup( 'firewall_dst' , 'global' ),
  $debug                 = params_lookup( 'debug' , 'global' ),
  $audit_only            = params_lookup( 'audit_only' , 'global' ),
  $noops                 = params_lookup( 'noops' ),
  $package               = params_lookup( 'package' ),
  $service               = params_lookup( 'service' ),
  $service_status        = params_lookup( 'service_status' ),
  $process               = params_lookup( 'process' ),
  $process_args          = params_lookup( 'process_args' ),
  $process_user          = params_lookup( 'process_user' ),
  $config_file           = params_lookup( 'config_file' ),
  $config_file_mode      = params_lookup( 'config_file_mode' ),
  $config_file_owner     = params_lookup( 'config_file_owner' ),
  $config_file_group     = params_lookup( 'config_file_group' ),
  $pid_file              = params_lookup( 'pid_file' ),
  $data_dir              = params_lookup( 'data_dir' ),
  $log_dir               = params_lookup( 'log_dir' ),
  $log_file              = params_lookup( 'log_file' ),
  $port                  = params_lookup( 'port' ),
  $protocol              = params_lookup( 'protocol' )
  ) inherits mongodb::params {

  $bool_use_10gen=any2bool($use_10gen)
  $bool_client_only=any2bool($client_only)
  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_service_autorestart=any2bool($service_autorestart)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_firewall=any2bool($firewall)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)

  ### Definition of some variables used in the module
  $manage_package = $mongodb::bool_absent ? {
    true  => 'absent',
    false => $mongodb::version,
  }

  $manage_service_enable = $mongodb::bool_disableboot ? {
    true    => false,
    default => $mongodb::bool_disable ? {
      true    => false,
      default => $mongodb::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $mongodb::bool_disable ? {
    true    => 'stopped',
    default =>  $mongodb::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_service_autorestart = $mongodb::bool_service_autorestart ? {
    true    => Service[mongodb],
    false   => undef,
  }

  $manage_file = $mongodb::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $mongodb::bool_absent == true
  or $mongodb::bool_disable == true
  or $mongodb::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  if $mongodb::bool_absent == true
  or $mongodb::bool_disable == true {
    $manage_firewall = false
  } else {
    $manage_firewall = true
  }

  $manage_audit = $mongodb::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $mongodb::bool_audit_only ? {
    true  => false,
    false => true,
  }

  ### Definition of real variables according to use_10gen parameter
  $real_package = $mongodb::package ? {
    ''      => $mongodb::bool_use_10gen ? {
      true  => $::operatingsystem ? {
        /(?i:Debian|Ubuntu|Mint)/ => 'mongodb-10gen',
        default                   => 'mongo-10gen-server',
      },
      false => 'mongodb-server'
    },
    default => $package,
  }

  $real_package_client = $mongodb::package_client ? {
    ''      => $mongodb::bool_use_10gen ? {
      true  => $::operatingsystem ? {
        /(?i:Debian|Ubuntu|Mint)/ => undef,
        default                   => [ 'mongo-10gen' ],
      },
      false => $::operatingsystem ? {
        /(?i:Debian|Ubuntu|Mint)/ => [ 'mongodb-clients' ],
        default                   => [ 'mongodb' , 'libmongodb' ],
      },
    },
    default => $package_client,
  }

  $real_service = $mongodb::service ? {
    ''      => $mongodb::bool_use_10gen ? {
      true  => $::operatingsystem ? {
        /(?i:RedHat|CentOS|Scientific|Fedora)/ => 'mongod',
        default                                => 'mongodb',
      },
      false => $::operatingsystem ? {
        /(?i:RedHat|CentOS|Scientific|Fedora)/ => 'mongod',
        default                                => 'mongodb',
      },
    },
    default => $service,
  }

  $real_config_file = $mongodb::config_file ? {
    ''      => $mongodb::bool_use_10gen ? {
      true  => $::operatingsystem ? {
        /(?i:RedHat|CentOS|Scientific|Fedora)/ => '/etc/mongod.conf',
        default                                => '/etc/mongodb.conf',
      },
      false => '/etc/mongodb.conf'
    },
    default => $config_file,
  }

  $real_data_dir = $mongodb::data_dir ? {
    ''      => $mongodb::bool_use_10gen ? {
      true  => $::operatingsystem ? {
        /(?i:RedHat|CentOS|Scientific|Fedora)/ => '/var/lib/mongo',
        default                                => '/var/lib/mongodb',
      },
      false => '/var/lib/mongodb',
    },
    default => $data_dir,
  }

  $real_log_dir = $mongodb::log_dir ? {
    ''      => $mongodb::bool_use_10gen ? {
      true  => $::operatingsystem ? {
        /(?i:RedHat|CentOS|Scientific|Fedora)/ => '/var/log/mongo',
        default                                => '/var/log/mongodb',
      },
      false => '/var/log/mongodb',
    },
    default => $log_dir,
  }

  $real_log_file = $mongodb::log_file ? {
    ''      => $mongodb::bool_use_10gen ? {
      true  => $::operatingsystem ? {
        /(?i:RedHat|CentOS|Scientific|Fedora)/ => '/var/log/mongo/mongod.log',
        default                                => '/var/log/mongodb/mongodb.log',
      },
      false => '/var/log/mongodb/mongodb.log',
    },
    default => $log_file,
  }

  $real_process_user = $mongodb::process_user ? {
    ''      => $mongodb::bool_use_10gen ? {
      true  => $::operatingsystem ? {
        /(?i:RedHat|CentOS|Scientific|Fedora)/ => 'mongod',
        default                                => 'mongodb',
      },
      false => 'mongodb',
    },
    default => $process_user,
  }

  $real_pid_file = $mongodb::pid_file ? {
    ''      => $mongodb::bool_use_10gen ? {
      true  => $::operatingsystem ? {
        /(?i:RedHat|CentOS|Scientific|Fedora)/ => '/var/run/mongodb/mongod.pid',
        default                                => '',
      },
      false => $::operatingsystem ? {
        /(?i:RedHat|CentOS|Scientific|Fedora)/ => '/var/run/mongodb/mongodb.pid',
        default                                => '',
      },
    },
    default => $pid_file,
  }

  $real_monitor_target = $mongodb::monitor_target ? {
    ''      => $mongodb::bind_ip,
    default => $monitor_target ,
  }

  $real_firewall_dst = $mongodb::firewall_dst ? {
    ''      => $mongodb::bind_ip,
    default => $firewall_dst,
  }

  ### Manage file contents
  $manage_file_source = $mongodb::source ? {
    ''        => undef,
    default   => $mongodb::source,
  }

  $manage_file_content = $mongodb::template ? {
    ''        => undef,
    default   => template($mongodb::template),
  }

  $package_require = $mongodb::dependency_class ? {
    ''      => undef,
    undef   => undef,
    default => Class[$mongodb::dependency_class],
  }

  ### Prerequisites
  if $mongodb::dependency_class {
    include $mongodb::dependency_class
  }

  ### Managed resources

  if $mongodb::real_package_client {
    include mongodb::client
  }

  if $bool_client_only != true {
    include mongodb::server
  }


  ### Include custom class if $my_class is set
  if $mongodb::my_class {
    include $mongodb::my_class
  }

  if $mongodb::keyfile {
    include mongodb::keyfile
  }

  ### Debugging, if enabled ( debug => true )
  if $mongodb::bool_debug == true {
    file { 'debug_mongodb':
      ensure  => $mongodb::manage_file,
      path    => "${settings::vardir}/debug-mongodb",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
      noop    => $mongodb::noops,
    }
  }

}
