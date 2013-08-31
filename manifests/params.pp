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

  $use_10gen = false
  $dependency_class = 'mongodb::dependency'
  $bind_ip = '127.0.0.1'
  $client_only = false
  $package_client = ''
  $keyfile = ''

  ### Names depend on use_10gen and are defined in the main class
  $package = ''
  $service = ''
  $config_file = ''
  $data_dir = ''
  $log_dir = ''
  $log_file = ''
  $pid_file = ''
  $process_user = ''

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = 'mongod'

  $process_args = ''

  $config_file_mode = $::operatingsystem ? {
    default => '0644',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $port = '27017'
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
  $monitor_target = ''
  $firewall = false
  $firewall_tool = ''
  $firewall_src = '0.0.0.0/0'
  $firewall_dst = ''
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false
  $noops = undef

}
