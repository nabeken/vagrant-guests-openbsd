[![Build Status](https://secure.travis-ci.org/nabeken/vagrant-guests-openbsd.png)](http://travis-ci.org/nabeken/vagrant-guests-openbsd)

# vagrant-guests-openbsd

Vagrant 1.1 has a build-in OpenBSD plugin but the plugin lacks multiple network and nfs mount support.

This plugins allows you to run OpenBSD under vagrant until Vagrant merges this changes.

## Installation

Add this line to your application's Gemfile:

    gem 'vagrant-guests-openbsd', :git => 'git://github.com/nabeken/vagrant-guests-openbsd'

And then execute:

    $ bundle

You should disable build-in OpenBSD plugin.

For example, in Mac OS X:

    $ sudo chmod 0000 /Applications/Vagrant/embedded/gems/gems/vagrant-1.1.2/plugins/guests/openbsd

## Usage

Add this line to your Vagrantfile:

    Vagrant.require_plugin "vagrant-guests-openbsd"
    Vagrant.configure("2") do |config|
      config.vm.guest = :openbsd

      # If you want hostonly network
      config.vm.network :private_network, ip: "192.168.67.10", netmask: "255.255.255.0"
      # If you want to mount folders with nfs
      config.vm.synced_folder "../", "/vagrant", :nfs => true

      # other config
      # ...
    end
