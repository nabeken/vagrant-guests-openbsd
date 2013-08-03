require 'vagrant'

module VagrantPlugins
  module GuestOpenBSD
    class Guest < Vagrant.plugin("2", :guest)
      def detect?(machine)
        machine.communicate.test('[ "$(uname -s)" = "OpenBSD" ]')
      end
    end
  end
end
