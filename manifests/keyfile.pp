# = Class: mongodb::keyfile
#
# This class installs mongodb::keyfile. It's included by the main mongodb class
#
class mongodb::keyfile {

  exec { 'generate_mongo_keyfile':
    command => "openssl rand -base64 753 > ${mongodb::keyfile}",
    path    => '/usr/bin:/bin:/usr/sbin:/sbin',
    creates => $mongodb::keyfile,
    notify  => Service['mongodb'],
  }
  file { $mongodb::keyfile:
    ensure  => present,
    mode    => '0600',
    owner   => $mongodb::real_process_user,
    group   => $mongodb::real_process_user,
    require => Exec['generate_mongo_keyfile'],
  }
}
