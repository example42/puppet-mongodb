# = Class: mongodb::server
#
# This class installs mongodb::server. It's included by the main mongodb class
#
class mongodb::server {

  package { 'mongodb':
    ensure  => $mongodb::manage_package,
    require => $mongodb::package_require,
    name    => $mongodb::real_package,
    noop    => $mongodb::noops,
  }

  service { 'mongodb':
    ensure     => $mongodb::manage_service_ensure,
    name       => $mongodb::real_service,
    enable     => $mongodb::manage_service_enable,
    hasstatus  => $mongodb::service_status,
    pattern    => $mongodb::process,
    require    => Package['mongodb'],
    noop       => $mongodb::noops,
  }

  file { 'mongodb.conf':
    ensure  => $mongodb::manage_file,
    path    => $mongodb::real_config_file,
    mode    => $mongodb::config_file_mode,
    owner   => $mongodb::config_file_owner,
    group   => $mongodb::config_file_group,
    require => Package['mongodb'],
    notify  => $mongodb::manage_service_autorestart,
    source  => $mongodb::manage_file_source,
    content => $mongodb::manage_file_content,
    replace => $mongodb::manage_file_replace,
    audit   => $mongodb::manage_audit,
    noop    => $mongodb::noops,
  }

  ### Provide puppi data, if enabled ( puppi => true )
  if $mongodb::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'mongodb':
      ensure    => $mongodb::manage_file,
      variables => $classvars,
      helper    => $mongodb::puppi_helper,
      noop      => $mongodb::noops,
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $mongodb::bool_monitor == true {
    if $mongodb::port != '' {
      monitor::port { "mongodb_${mongodb::protocol}_${mongodb::port}":
        protocol => $mongodb::protocol,
        port     => $mongodb::port,
        target   => $mongodb::real_monitor_target,
        tool     => $mongodb::monitor_tool,
        enable   => $mongodb::manage_monitor,
        noop     => $mongodb::noops,
      }
    }
    if $mongodb::real_service != '' {
      monitor::process { 'mongodb_process':
        process  => $mongodb::process,
        service  => $mongodb::service,
        pidfile  => $mongodb::real_pid_file,
        user     => $mongodb::process_user,
        argument => $mongodb::process_args,
        tool     => $mongodb::monitor_tool,
        enable   => $mongodb::manage_monitor,
        noop     => $mongodb::noops,
      }
    }
  }


  ### Firewall management, if enabled ( firewall => true )
  if $mongodb::bool_firewall == true and $mongodb::port != '' {
    firewall { "mongodb_${mongodb::protocol}_${mongodb::port}":
      source      => $mongodb::firewall_src,
      destination => $mongodb::real_firewall_dst,
      protocol    => $mongodb::protocol,
      port        => $mongodb::port,
      action      => 'allow',
      direction   => 'input',
      tool        => $mongodb::firewall_tool,
      enable      => $mongodb::manage_firewall,
      noop        => $mongodb::noops,
    }
  }

}
