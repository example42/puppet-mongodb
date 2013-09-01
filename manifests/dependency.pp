# Class: mongodb::dependency
#
# This class installs mongodb dependency
#
# == Variables
#
# Refer to mongodb class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by mongodb if the parameter
# install_dependency is set to true
# Note: This class may contain resources available on the
# Example42 modules set
#
class mongodb::dependency {

  case $::operatingsystem {
    redhat,centos,scientific,oraclelinux : {
      if $mongodb::bool_use_10gen == true {
        require 'yum::repo::10gen'
      } else {
        # require yum::repo::epel
      }
    }
    ubuntu,debian : {
      if $mongodb::bool_use_10gen == true {
        require 'apt::repo::10gen'
      }
    }
    default: { }
  }
}
