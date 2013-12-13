# Class: mongodb::repo::10gen
#
# This class installs mongodb 10gen repository
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by mongodb if the parameter
# repo_class is set to 'mongodb::repo::10gen'
#
class mongodb::repo::10gen {

  case $::osfamily {

    RedHat : {
      require 'yum::repo::10gen'
    }
    Debian : {
      require 'apt::repo::10gen'
    }
    default: { }
  }
}
