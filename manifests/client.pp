# = Class: mongodb::client
#
# This class installs mongodb::client. It's included by the main mongodb class
#
class mongodb::client {

  if $mongodb::real_package_client {
    package { 'mongodb-client':
      ensure  => $mongodb::manage_package,
      name    => $mongodb::real_package_client,
      noop    => $mongodb::bool_noops,
    }
  }

}
