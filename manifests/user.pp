# Define: mongodb::user
#
define mongodb::user (
  $password,
  $roles       = '[]',
  $db_host     = '127.0.0.1',
  $db_port     = '27017',
  $db_name     = 'test',
  $cmd_options = '',
  $js_dir      = '/root/puppet-mongodb',
  $ensure      = 'present'
  ) {

  include mongodb

  if (!defined(File[$js_dir])) {
    file {$js_dir:
      ensure => directory,
      path   => $js_dir,
      owner  => 'root',
      group  => 'root',
      mode   => '0700',
    }
  }

  $mongodb_script_user = "mongo_user-${name}_${db_name}.js"

  file { $mongodb_script_user:
      ensure  => present,
      mode    => '0600',
      owner   => 'root',
      group   => 'root',
      path    => "${js_dir}/${mongodb_script_user}",
      content => template('mongodb/user.js.erb'),
  }

  exec { "mongo_user-${name}-${db_name}":
      command     => "mongo ${cmd_options} ${db_host}:${db_port}/${db_name} ${js_dir}/${mongodb_script_user}",
      require     => Service['mongodb'],
      subscribe   => File[$mongodb_script_user],
      path        => [ '/usr/bin' , '/usr/sbin' ],
      refreshonly => true,
  }

}

