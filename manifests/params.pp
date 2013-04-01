# Class: mongodb::params
#
# This class defines default parameters used by the main module class mongodb
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to mongodb class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class mongodb::params {

  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'mongodb',
  }

  $service = $::operatingsystem ? {
    default => 'mongodb',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'mongodb',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    default => 'mongodb',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/mongodb',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/mongodb/mongodb.conf',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/mongodb',
    default                   => '/etc/sysconfig/mongodb',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/mongodb.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '/etc/mongodb',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/mongodb',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/mongodb/mongodb.log',
  }

  $port = '42'
  $protocol = 'tcp'

  # General Settings
  $my_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = ''
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false
  $noops = false

}
