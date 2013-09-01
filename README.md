# Puppet module: mongodb

This is a Puppet module for mongodb based on the second generation layout ("NextGen") of Example42 Puppet Modules.

Made by Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-mongodb

Released under the terms of Apache 2 License.

This module requires functions provided by the Example42 Puppi module (you need it even if you don't use and install Puppi)

For detailed info about the logic and usage patterns of Example42 modules check the DOCS directory on Example42 main modules set.


## USAGE - Installation and configuration

* Install mongodb with default settings

        class { 'mongodb': }

* Install mongodb using 10Gen repository (provided by Example42 yum/apt modules)

        class { 'mongodb':
          use_10gen => true,
        }

* Install mongodb using 10Gen repository (but provide them with your own class)

        class { 'mongodb':
          use_10gen          => true,
          dependency_class   => 'site::dependency_mongodb',
        }

* Install mongodb, make it bind to $::ipaddress (default bind_ip is 127.0.0.1) and use the module's sample template to enable it.

        class { 'mongodb':
          bind_ip  => $::ipaddress,
          template => 'mongodb/mongodb.conf.erb',
        }

* Install mongodb and provide an hash of custom parameters
  Note: you must specify a template file where there are the relevant options_lookups for the keys you specified in the options hash. Here is used the module's sample one, where defaults for most of the options are set.

        class { 'mongodb':
          bind_ip  => $::ipaddress,
          template => 'mongodb/mongodb.conf.erb',
          options  => {
            slave  => true,
            source => '1.2.3.4',
          }
        }

        class { 'mongodb':
          bind_ip  => '1.2.3.4',
          template => 'mongodb/mongodb.conf.erb',
          options  => {
            master  => true,
            verbose => true,
          }
        }


* Install only the client package (Default: false, both client and server are installed)

        class { 'mongodb':
          client_only => true,
        }


* Install a specific version of mongodb package

        class { 'mongodb':
          version => '1.0.1',
        }

* Disable mongodb service.

        class { 'mongodb':
          disable => true
        }

* Remove mongodb package

        class { 'mongodb':
          absent => true
        }

* Enable auditing without without making changes on existing mongodb configuration *files*

        class { 'mongodb':
          audit_only => true
        }

* Module dry-run: Do not make any change on *all* the resources provided by the module

        class { 'mongodb':
          noops => true
        }


## USAGE - Modules defines

The module provides some defines for different oprations. Refer to code and inline documentatin for usage details.

* Create and manage users

        mongodb::user { 'joe':
          password => 'S$cr£t',
        }



## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { 'mongodb':
          source => [ "puppet:///modules/example42/mongodb/mongodb.conf-${hostname}" , "puppet:///modules/example42/mongodb/mongodb.conf" ], 
        }


* Use custom template for main config file. Note that template and source arguments are alternative. 

        class { 'mongodb':
          template => 'example42/mongodb/mongodb.conf.erb',
        }

* Automatically include a custom subclass

        class { 'mongodb':
          my_class => 'example42::my_mongodb',
        }


## USAGE - Example42 extensions management 
* Activate puppi (recommended, but disabled by default)

        class { 'mongodb':
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with a puppi::helper define ) to customize the output of puppi commands 

        class { 'mongodb':
          puppi        => true,
          puppi_helper => 'myhelper', 
        }

* Activate automatic monitoring (recommended, but disabled by default). This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { 'mongodb':
          monitor      => true,
          monitor_tool => [ 'nagios' , 'monit' , 'munin' ],
        }

* Activate automatic firewalling. This option requires the usage of Example42 firewall and relevant firewall tools modules

        class { 'mongodb':       
          firewall      => true,
          firewall_tool => 'iptables',
          firewall_src  => '10.42.0.0/24',
          firewall_dst  => $ipaddress_eth0,
        }


## CONTINUOUS TESTING

Travis {<img src="https://travis-ci.org/example42/puppet-mongodb.png?branch=master" alt="Build Status" />}[https://travis-ci.org/example42/puppet-mongodb]
