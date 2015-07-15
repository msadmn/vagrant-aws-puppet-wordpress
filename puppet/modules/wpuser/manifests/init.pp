class wpuser {

user { 'wordpress':
  name                 => 'wordpress',
  ensure               => 'present',
  allowdupe            => 'false',
  comment              => 'Wordpress User',
  expiry               => 'absent',
  forcelocal           => 'true',
  gid                  => 'wordpress',
  groups               => 'wordpress',
  home                 => '/home/wordpress',
  managehome           => 'false',
  password             => '*',
  password_max_age     => '0',
  password_min_age     => '0',
  purge_ssh_keys       => 'false',
  shell                => '/bin/false',
  system               => 'false',
  uid                  => '10000'
}

group { 'wordpress':
  name                 => 'wordpress',
  ensure               => 'present',
  allowdupe            => 'false',
  forcelocal           => 'true',
  gid                  => '10000',
  members              => 'wordpress',
  system               => 'false'
	}
}
