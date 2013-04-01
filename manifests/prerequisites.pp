# Class: mongodb::prerequisites
#
# This class installs mongodb prerequisites
#
# == Variables
#
# Refer to mongodb class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by mongodb if the parameter
# install_prerequisites is set to true
# Note: This class may contain resources available on the
# Example42 modules set
#
class mongodb::prerequisites {

  case $::operatingsystem {
    redhat,centos,scientific,oraclelinux : {
      require yum::repo::10gen
    }
    ubuntu,debian : {
      require apt::repo::10gen
    }
    default: { }
  }
}
