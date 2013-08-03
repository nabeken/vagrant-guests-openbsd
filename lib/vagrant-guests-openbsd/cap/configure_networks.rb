module VagrantPlugins
  module GuestOpenBSD
    module Cap
      class ConfigureNetworks
        def self.configure_networks(machine, networks)
          # remove any hostname.em expect hostname.em0
          machine.communicate.sudo("[ -f /etc/hostname.em0 ] && mv /etc/hostname.em0 /tmp")
          machine.communicate.sudo("rm /etc/hostname.em* || :")
          machine.communicate.sudo("[ -f /tmp/hostname.em0 ] && mv /tmp/hostname.em0 /etc")

          networks.each do |network|
            case network[:type]
            when :static
              machine.communicate.sudo("su -m root -c 'echo inet #{network[:ip]} #{network[:netmask]}" +
                                  " > /etc/hostname.em#{network[:interface]}'")
              machine.communicate.sudo("sh /etc/netstart em#{network[:interface]}")
            when :dhcp
              machine.communicate.sudo("su -m root -c 'echo dhcp > /etc/hostname.em#{network[:interface]}'")
              machine.communicate.sudo("sh /etc/netstart em#{network[:interface]}")
            end
          end
        end
      end
    end
  end
end
