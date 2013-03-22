require 'vagrant'
require 'log4r'

module VagrantPlugins
  module GuestOpenBSD
    class Guest < Vagrant.plugin("2", :guest)
      class OpenBSDError < Vagrant::Errors::VagrantError
        error_namespace("vagrant.guest.openbsd")
      end

      def initialize(*args)
        super
        @logger = Log4r::Logger.new("vagrant::guest::openbsd")
      end

      def halt
        vm.communicate.sudo("shutdown -hp now")
      end

      def mount_shared_folder(name, guestpath, options)
        @logger.info("OpenBSD does not have shared folder support. Use nfs option instead.")
      end

      def mount_nfs(ip, folders)
        folders.each do |name, opts|
          vm.communicate.sudo("mkdir -p #{opts[:guestpath]}")
          vm.communicate.sudo("mount '#{ip}:#{opts[:hostpath]}' '#{opts[:guestpath]}'")
        end
      end

      def configure_networks(networks)
        # remove any hostname.em expect hostname.em0
        vm.communicate.sudo("[ -f /etc/hostname.em0 ] && mv /etc/hostname.em0 /tmp")
        vm.communicate.sudo("rm /etc/hostname.em* || :")
        vm.communicate.sudo("[ -f /tmp/hostname.em0 ] && mv /tmp/hostname.em0 /etc")

        networks.each do |network|
          case network[:type]
          when :static
            vm.communicate.sudo("su -m root -c 'echo inet #{network[:ip]} #{network[:netmask]}" +
                                " > /etc/hostname.em#{network[:interface]}'")
            vm.communicate.sudo("sh /etc/netstart em#{network[:interface]}")
          when :dhcp
            vm.communicate.sudo("su -m root -c 'echo dhcp > /etc/hostname.em#{network[:interface]}'")
            vm.communicate.sudo("sh /etc/netstart em#{network[:interface]}")
          end
        end
      end

      def change_host_name(name)
        if !vm.communicate.test("[ `hostname -f` = #{name} ] || [ `hostname -s` = #{name} ]")
          vm.communicate.sudo("su -m root -c 'echo #{name} > /etc/myname'")
          vm.communicate.sudo("hostname #{name}")
        end
      end
    end
  end
end
