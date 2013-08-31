# = Class: mongodb::client
#
# This class installs mongodb::client. It's included by the main mongodb class
#
class mongodb::client {

  if $mongodb::real_package_client {
    package { 'mongodb-client':
      ensure  => $mongodb::manage_package,
      require => $mongodb::package_require,
      name    => $mongodb::real_package_client,
      noop    => $mongodb::noops,
    }
  }

}
