# Vagrant AWS puppet and Wordpress Demo

And exercise of Infrastrcture as code. 
This is a simple demo to spin up 2 instances in AWS, web(apache) and db(mysql) via Vagrant, making use of Vagrants puppet provisioning/standalone puppet, configuring and installing the required software ( MySQL, Apache, Wordpress, ) setting host file so servers can communicate. Instances should be started one at a time, due to bugin the hostmanager plugin.
  
Instances
---
wpweb1 - Web Server 1 ( running Apache and Wordpress ) 
wpdb1 - DB Server 1 (running Mysql ) 

Deployment
----------
The servers use the RedHat 6  official AWS  image, but you are free to use any AMI you choose, however it does not work with Amazon Linux AMI's. 

You will need to install Vagrant and these plugins:
* Vagrant-aws-plugin
* Vagrant hostmaster plugin

then on top of that we install:
* Puppet
* Facter
* Hiera
* Apache
* Mysql
* Mysql-client
* Php
* Php-mysql

In order to use the Vagrant puppet provisioning you will need to have installed the following puppet modules locally. However i have also  included them in this repo ) 

* hunner/wordpress
* puppet/mysql
* puppet/apache

Example: 
```
$ puppet module install hunner-wordpress  --target-dir /path/to/dir
```

Recommended spin-up process:
-----------------------------
    vagrant up wpdb1 (hit enter at the password prompts)
    vagrant up wpweb1 (hit enter at the password prompts)

grab the public IP and go!


