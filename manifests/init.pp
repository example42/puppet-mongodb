#
# = Class: mongodb
#
# This class installs and manages mongodb
#
#
# == Parameters
#
# Refer to https://github.com/stdmod for official documentation
# on the stdmod parameters used
#
class mongodb (

  $server_package_name,
  $server_package_ensure     = 'present',

  $client_package_name,
  $client_package_ensure     = 'present',

  $service_name,
  $service_ensure            = 'running',
  $service_enable            = true,

  $config_file_path,
  $config_file_require       = 'Package[mongodb_server]',
  $config_file_notify        = 'Service[mongodb]',
  $config_file_source        = undef,
  $config_file_template      = undef,
  $config_file_content       = undef,
  $config_file_options_hash  = { } ,
  $config_file_owner,
  $config_file_group,
  $config_file_mode,

  $config_dir_path,
  $config_dir_source         = undef,
  $config_dir_purge          = false,
  $config_dir_recurse        = true,

  $process_user,

  $conf_hash                 = undef,

  $repo_class                = undef,
  $my_class                  = undef,

  $monitor_class             = undef,
  $monitor_options_hash      = { } ,

  $firewall_class            = undef,
  $firewall_options_hash     = { } ,

  $scope_hash_filter         = '(uptime.*|timestamp)',

  $tcp_port                  = undef,
  $udp_port                  = undef,

  ) {


  # Class variables validation and management

  validate_bool($service_enable)
  validate_bool($config_dir_recurse)
  validate_bool($config_dir_purge)
  if $config_file_options_hash { validate_hash($config_file_options_hash) }
  if $monitor_options_hash { validate_hash($monitor_options_hash) }
  if $firewall_options_hash { validate_hash($firewall_options_hash) }

  $manage_config_file_content = default_content($config_file_content, $config_file_template)

  $manage_config_file_notify  = $config_file_notify ? {
    'class_default' => 'Service[mongodb]',
    ''              => undef,
    default         => $config_file_notify,
  }

  if $package_ensure == 'absent' {
    $manage_service_enable = undef
    $manage_service_ensure = stopped
    $config_dir_ensure = absent
    $config_file_ensure = absent
  } else {
    $manage_service_enable = $service_enable ? {
      ''      => undef,
      'undef' => undef,
      default => $service_enable,
    }
    $manage_service_ensure = $service_ensure ? {
      ''      => undef,
      'undef' => undef,
      default => $service_ensure,
    }
    $config_dir_ensure = directory
    $config_file_ensure = present
  }


  # Dependency class
  anchor { '::mongodb::begin': }
  anchor { '::mongodb::end': }

  if $mongodb::repo_class {
    include $mongodb::repo_class
    Anchor['::mongodb::begin']
    -> Class[$mongodb::repo_class]
    -> Package[$mongodb::server_package_name]
    -> Anchor['::mongodb::end']
  }


  # Resources managed

  if $mongodb::server_package_name {
    package { $mongodb::server_package_name:
      ensure   => $mongodb::server_package_ensure,
      name     => $mongodb::server_package_name,
      alias    => 'mongodb_server',
    }
  }

  if $mongodb::client_package_name {
    package { $mongodb::client_package_name:
      ensure   => $mongodb::client_package_ensure,
      name     => $mongodb::client_package_name,
      alias    => 'mongodb_client',
    }
  }

  if $mongodb::config_file_path {
    file { $mongodb::config_file_path:
      ensure  => $mongodb::config_file_ensure,
      path    => $mongodb::config_file_path,
      mode    => $mongodb::config_file_mode,
      owner   => $mongodb::config_file_owner,
      group   => $mongodb::config_file_group,
      source  => $mongodb::config_file_source,
      content => $mongodb::manage_config_file_content,
      notify  => $mongodb::manage_config_file_notify,
      require => $mongodb::config_file_require,
      alias   => 'mongodb.conf',
    }
  }

  if $mongodb::config_dir_source {
    file { $mongodb::config_dir_path:
      ensure  => $mongodb::config_dir_ensure,
      path    => $mongodb::config_dir_path,
      source  => $mongodb::config_dir_source,
      recurse => $mongodb::config_dir_recurse,
      purge   => $mongodb::config_dir_purge,
      force   => $mongodb::config_dir_purge,
      notify  => $mongodb::manage_config_file_notify,
      require => $mongodb::config_file_require,
      alias   => 'mongodb.dir',
    }
  }

  if $mongodb::service_name {
    service { $mongodb::service_name:
      ensure     => $mongodb::manage_service_ensure,
      name       => $mongodb::service_name,
      enable     => $mongodb::manage_service_enable,
      alias      => 'mongodb',
    }
  }


  # Extra classes

  if $conf_hash {
    create_resources('mongodb::conf', $conf_hash)
  }

  if $mongodb::my_class {
    include $mongodb::my_class
  }

  if $mongodb::monitor_class {
    class { $mongodb::monitor_class:
      options_hash => $mongodb::monitor_options_hash,
      scope_hash   => {},
    }
  }

  if $mongodb::firewall_class {
    class { $mongodb::firewall_class:
      options_hash => $mongodb::firewall_options_hash,
      scope_hash   => {},
    }
  }

}

