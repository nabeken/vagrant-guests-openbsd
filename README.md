[![Build Status](https://secure.travis-ci.org/nabeken/vagrant-guests-openbsd.png)](http://travis-ci.org/nabeken/vagrant-guests-openbsd)

# vagrant-guests-openbsd

**OpenBSD support in Vagrant >= 1.3.0 has been improved. This plugin is no longer necessary.**

Vagrant >= 1.1 && <= 1.2.7 has a built-in OpenBSD plugin but the plugin lacks multiple network and nfs mount support.

This plugins allows you to run OpenBSD under vagrant until Vagrant merges this changes.

## Installation

    $ vagrant plugin install vagrant-guests-openbsd

## Usage

Add this line to your Vagrantfile:

    Vagrant.require_plugin "vagrant-guests-openbsd"
    Vagrant.configure("2") do |config|
      config.vm.guest = :openbsd_v2

      # If you want hostonly network
      config.vm.network :private_network, ip: "192.168.67.10", netmask: "255.255.255.0"
      # If you want to mount folders with nfs
      config.vm.synced_folder "../", "/vagrant", :nfs => true
      # If you want not to mount any folders, set :disabled => true
      config.vm.synced_folder "../", "/vagrant", :disabled => true

      # other config
      # ...
    end

You shoud use ':openbsd\_v2' for 'config.vm.guest' to avoid name conflict with built-in plugin.

# ChangeLog

## 0.0.3 (2013-08-03)

 * Add Vagrant 1.2.7 support
