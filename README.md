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
