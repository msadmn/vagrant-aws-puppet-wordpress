# -*- mode: ruby -*-
# vi: set ft=ruby :

#box provision. same for all boxen Centos with puppet baked in. 
Vagrant.configure("2") do |config|
#config.vm.box = "perconajayj/centos-x86_64"
config.vm.box = "dummy"
config.hostmanager.enabled = true
config.hostmanager.manage_host = true
config.hostmanager.ignore_private_ip = false
config.hostmanager.include_offline = false 
config.hostmanager.ip_resolver = proc do |machine|
  result = ""
  machine.communicate.execute("ifconfig eth0") do |type, data|
    result << data if type == :stdout
  end
  (ip = /inet addr:(\d+\.\d+\.\d+\.\d+)/.match(result)) && ip[1]
end

#provision the webserver
 config.vm.define :wpweb1 do |wpweb1_config|
    wpweb1_config.vm.provider :aws do |aws, override|
#    aws.ami = "ami-1ecae776" ec2-ami
#     aws.ami = "ami-3ecd1e57" centos
    config.ssh.pty= true
    aws.ami = "ami-b18c62da"
    aws.access_key_id = "AKIAI2RLO266E77CNEFQ"
    aws.secret_access_key = "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"
    aws.keypair_name = "melawskey2015"
    aws.instance_type = "t2.micro"
    aws.subnet_id = "subnet-c76641b0"
    aws.security_groups = "sg-54d41d33"       
    aws.associate_public_ip = "true"
    aws.tags = {
        Name: 'Wordpress Web Server 1'
      }
    aws.user_data = "#!/bin/bash\nsed -i -e 's/^Defaults.*requiretty/# Defaults requiretty/g' /etc/sudoers"
    override.ssh.username = "ec2-user"
#     override.ssh.username =  "root"
    override.ssh.private_key_path = "/Users/mhoward/melawskey2015.pem"

wpweb1_config.vm.provision "shell", :inline => <<-SHELL
#	  hostnamectl set-hostname wpweb1.msadmn.co.uk
          yum -y update
          yum -y install httpd php puppet
        SHELL

      wpweb1_config.vm.provision :puppet do |puppet|
        puppet.manifests_path = 'puppet/manifests'
        puppet.manifest_file = 'web1.pp'
        puppet.module_path = 'puppet/modules'
      end
      end 
      end
#provision the dbserver

 config.vm.define :wpdb1 do |wpdb1_config|
    wpdb1_config.vm.provider :aws do |aws, override|
#    aws.ami = "ami-1ecae776"  ec2-ami
     aws.ami = "ami-b18c62da"
     config.ssh.pty= true
    aws.access_key_id = "AKIAI2RLO266E77CNEFQ"
    aws.secret_access_key = "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"
    aws.keypair_name = "melawskey2015"
    aws.instance_type = "t2.micro"
    aws.subnet_id = "subnet-c76641b0"
    aws.security_groups = "sg-54d41d33"
    aws.associate_public_ip = "true"
    aws.tags = {
        Name: 'Wordpress DB Server 1'
      }
    aws.user_data = "#!/bin/bash\nsed -i -e 's/^Defaults.*requiretty/# Defaults requiretty/g' /etc/sudoers"
#    override.ssh.username = "root"
    override.ssh.username = "ec2-user"
    override.ssh.private_key_path = "/Users/mhoward/melawskey2015.pem"

wpdb1_config.vm.provision "shell", :inline => <<-SHELL
#          hostnamectl set-hostname wpdb1.msadmn.co.uk
          yum -y update
          yum -y install mysql-server puppet
        SHELL

      wpdb1_config.vm.provision :puppet do |puppet|
        puppet.manifests_path = 'puppet/manifests'
        puppet.manifest_file = 'db.pp'
        puppet.module_path = 'puppet/modules'
      end
      end
      end

#provision the puppetmaster
#
# config.vm.define :pm do |pm_config|
#    pm_config.vm.provider :aws do |aws, override|
#    aws.access_key_id = "AKIAI2RLO266E77CNEFQ"
#    aws.secret_access_key = "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"
#    aws.keypair_name = "melawskey2015"
#    aws.instance_type = "t2.micro"
#    aws.subnet_id = "subnet-c76641b0"
#    aws.security_groups = "sg-54d41d33"
#    aws.associate_public_ip = "true"
#    aws.tags = {
#        Name: 'PuppetMaster'
#      }
#    override.ssh.username = "root"
#    override.ssh.private_key_path = "/Users/mhoward/melawskey2015.pem"
#
#pm_config.vm.provision "shell", :inline => <<-SHELL
#          hostnamectl set-hostname puppetmaster.msadmn.co.uk
#          yum -y update
#          yum -y install facter hiera rubygems
#	  puppet module install hunner-wordpress
#       SHELL
#
#      wpdb1_config.vm.provision :puppet do |puppet|
#        puppet.manifests_path = 'puppet/manifests'
#        puppet.manifest_file = 'db.pp'
#        puppet.module_path = 'puppet/modules'
#      end
#      end
#      end
#
#
#
end
