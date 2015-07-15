
#include system user and group for wordpress
include 'wpuser'

class { 'selinux':
  mode => 'permissive',
}

# execute 'yum update'
exec { 'yum-update':                   # exec resource named 'yum-update'
  command => '/usr/bin/yum update'  # command this resource will run
}


# ensure httpd service is running
#service { 'httpd':
#  ensure => running,
#}


# install php package
package { 'php':
  require => Exec['yum-update'],        # require 'yum-update' before installing
  ensure => installed,
}

# install mysql client
    package { 'mysql':
        ensure => 'present',
    }

# install php-mysql client
    package { 'php-mysql':
        ensure => 'present',
    }

# ensure info.php file exists
#file { '/var/www/html/info.php':
#  ensure => file,
#  content => '<?php  phpinfo(); ?>',    # phpinfo code
#  require => Package['httpd'],        # require 'httpd' package before creating
#} 



class { 'apache':                # use the "apache" module
  default_vhost => false,        # don't use the default vhost
  default_mods => false,         # don't load default mods
  mpm_module => 'prefork',        # use the "prefork" mpm_module
}


class { 'wordpress':
  install_url => 'http://wordpress.org',
  install_dir => '/var/www/html',
  wp_owner    => 'apache',
  wp_group    => 'apache',
  db_user     => 'wordpress',
  db_password => 'abc123',
  db_host     => 'wpdb1',
  create_db => false,
  create_db_user => false,
}

include apache::mod::php        # include mod php
  apache::vhost { 'devops.msadmn.co.uk':  # create a vhost called "example.com"
   port    => '80',               # use port 80
   docroot => '/var/www/html',     # set the docroot to the /var/www/html
   docroot_owner => 'apache',
   docroot_group => 'apache',
}

#wordpress

#mysql::db { 'wordpress':
#  user     => 'wordpress',
#  password => 'abc123',
#  host     => 'wpdb1',
#}

#class { 'wordpress': install_url => 'http://wordpress.org',
#  install_dir => '/var/www/wxxxordpress',
#  wp_owner    => 'wordpress',
#  wp_group    => 'wordpress',
#  db_user     => 'wordpress', db_password => 'abc123',
#  db_host     => '10.0.0.145', create_db => false,
#  create_db_user => false,
#}


