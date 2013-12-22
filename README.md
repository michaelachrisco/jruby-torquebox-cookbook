jruby-torquebox-cookbook
==================

A cookbook to provision an instance with jruby and torquebox gem

Installs the following and creates a "deployer" user with root access
    
    Java
    Ruby
    Rbenv
    Jruby
    Bundler
    Torquebox
    Torquebox Backstage
     
Todo:

1. Install torquebox as a service
3. Deploy the torquebox backstage app   
4. Provision a database with postgres

# Setup

Install [Vagrant][1]

Install chef
    
    $ gem install chef

Install knife-solo and berkshelf
    
    $gem install knife-solo berkshelf

#Run locally on Virtualbox
    
    $ vagrant up
    $ vagrant ssh
    
Name your node, in the case, <catalog>  and add to ssh config file
    
    $ vagrant ssh-config --host catalog >> ~/.ssh/config

Vagrant creates an vagrant user as superuser on virtualbox

    $ knife solo prepare vagrant@catalog
    $ cd chef-repo
    $ knife solo cook vagrant@catalog
    $ vagrant ssh

And you should see
    
    Welcome to your Vagrant-built virtual machine.
    Last login: Wed Dec  4 01:37:33 2013 from 10.0.2.2
    vagrant@catalog:~$ rbenv versions
      system
      * jruby-1.7.8 (set by /usr/local/rbenv/version)
      vagrant@catalog:~$ which torquebox
      /usr/local/rbenv/shims/torquebox
        $ sudo torquebox run
        
And torquebox starts successfully. This should be run as a service by the torquebox_user.
      
#Run on AWS

Select AMI from [Ubuntu Cloud finder][2]. Use EBS backed volume in US East with Arch i386 and name Precise same as the vagrant virtual box 

    $ vagrant up --provider=aws

aws creates an ubuntu user as superuser, so vagrant ssh logs in as ubuntu user

    $ vagrant ssh-config --host catalog >> ~/.ssh/config
    $ knife solo prepare ubuntu@catalog
    $ cd chef-repo
    $ knife solo cook ubuntu@catalog
    

  [1]: http://www.vagrantup.com/
  [2]: http://cloud-images.ubuntu.com/locator/ec2/ 
  
   




