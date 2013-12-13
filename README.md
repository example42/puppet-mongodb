#mongodb

####Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [Resources managed by mongodb module](#resources-managed-by-mongodb-module)
    * [Setup requirements](#setup-requirements)
    * [Beginning with module mongodb](#beginning-with-module-mongodb)
4. [Usage](#usage)
5. [Operating Systems Support](#operating-systems-support)
6. [Development](#development)

##Overview

This module installs, manages and configures mongodb.

##Module Description

The module is based on **stdmod** naming standards version 0.9.0.

Refer to http://github.com/stdmod/ for complete documentation on the common parameters.


##Setup

###Resources managed by mongodb module
* This module installs the mongodb package
* Enables the mongodb service
* Can manage all the configuration files (by default no file is changed)

###Setup Requirements
* PuppetLabs [stdlib module](https://github.com/puppetlabs/puppetlabs-stdlib)
* StdMod [stdmod module](https://github.com/stdmod/stdmod)
* Ripieenar [module_data](https://github.com/ripienaar/puppet-module-data)
* Puppet version >= 2.7.x
* Facter version >= 1.6.2

###Beginning with module mongodb

To install the package provided by the module just include it:

        include mongodb

The main class arguments can be provided either via Hiera (from Puppet 3.x) or direct parameters:

        class { 'mongodb':
          parameter => value,
        }

The module provides a generic define to manage any mongodb configuration file:

        mongodb::conf { 'sample.conf':
          content => '# Test',
        }

To create and manage users:

        mongodb::user { 'joe':
          password => 'S$cr£t',
        }


##Usage

* A common way to use this module involves the management of the main configuration file via a custom template (provided in a custom site module):

        class { 'mongodb':
          config_file_template => 'site/mongodb/mongodb.conf.erb',
        }

* You can write custom templates that use setting provided but the config_file_options_hash paramenter

        class { 'mongodb':
          config_file_template      => 'site/mongodb/mongodb.conf.erb',
          config_file_options_hash  => {
            opt  => 'value',
            opt2 => 'value2',
          },
        }

* Use custom source (here an array) for main configuration file. Note that template and source arguments are alternative.

        class { 'mongodb':
          config_file_source => [ "puppet:///modules/site/mongodb/mongodb.conf-${hostname}" ,
                                  "puppet:///modules/site/mongodb/mongodb.conf" ],
        }


* Use custom source directory for the whole configuration directory, where present.

        class { 'mongodb':
          config_dir_source  => 'puppet:///modules/site/mongodb/conf/',
        }

* Use custom source directory for the whole configuration directory and purge all the local files that are not on the dir.
  Note: This option can be used to be sure that the content of a directory is exactly the same you expect, but it is desctructive and may remove files.

        class { 'mongodb':
          config_dir_source => 'puppet:///modules/site/mongodb/conf/',
          config_dir_purge  => true, # Default: false.
        }

* Use custom source directory for the whole configuration dir and define recursing policy.

        class { 'mongodb':
          config_dir_source    => 'puppet:///modules/site/mongodb/conf/',
          config_dir_recursion => false, # Default: true.
        }

* Provide an hash of files resources to be created with mongodb::conf.

        class { 'mongodb':
          conf_hash => {
            'mongodb.conf' => {
              template => 'site/mongodb/mongodb.conf',
            },
            'mongodb.other.conf' => {
              template => 'site/mongodb/mongodb.other.conf',
            },
          },
        }

* Do not trigger a service restart when a config file changes.

        class { 'mongodb':
          config_dir_notify => '', # Default: Service[mongodb]
        }

* Install only the mongodb client (by defalut both server and client are installed

        class { 'mongodb':
          server_package_name => '',
        }

* Use 10gen repository

        class { 'mongodb':
          repo_class => 'mongodb::repo::10gen',
        }


##Operating Systems Support

This is tested on these OS:
- RedHat osfamily 5 and 6
- Debian 6 and 7
- Ubuntu 10.04 and 12.04


##Development

Pull requests (PR) and bug reports via GitHub are welcomed.

When submitting PR please follow these quidelines:
- Provide puppet-lint compliant code
- If possible provide rspec tests
- Follow the module style and stdmod naming standards

When submitting bug report please include or link:
- The Puppet code that triggers the error
- The output of facter on the system where you try it
- All the relevant error logs
- Any other information useful to undestand the context
