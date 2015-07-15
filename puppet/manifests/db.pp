#include 'selinux'

class {'selinux':
  mode => 'permissive',
}

# execute 'yum update'
exec { 'yum':                    # exec resource named 'yum'
  command => '/usr/bin/yum -y update'  # command this resource will run
}

# install mysql-server package
#apackage { 'mysql-server':
#  require => Exec['yum'],        # require 'yum' before #installing
#  ensure => installed,
#}

#class mysql {
#    package { 'mysql-server':
#        ensure => 'present',
#    }
 
#    service { 'mysqld':
#        ensure => 'running',
#        enable => true,        hasrestart => true,
#        hasstatus => true,
#        subscribe => Package['mysql-server'],
#    }

class { 'mysql::server':
  root_password => 'password',
  override_options => {
    'mysqld' => {
      'bind-address' => '0.0.0.0',
    }
  }
}

mysql::db {'wordpress':
	user => 'wordpress',
	password => 'abc123',
	host => 'wpweb1',
	ensure => 'present',
        require => File['/root/.my.cnf'],
}

 
    # Equivalent to /usr/bin/mysql_secure_installation without providing or setting a password
#    exec { 'mysql_secure_installation':
#        command => '/usr/bin/mysql -uroot -e "DELETE FROM mysql.user WHERE User=\'\'; DELETE FROM mysql.user WHERE User=\'root\' AND Host NOT IN (\'localhost\', \'127.0.0.1\', \'::1\'); DROP DATABASE IF EXISTS test; FLUSH PRIVILEGES;" mysql',
#        require => Service['mysqld'],
#    }
#}
 


