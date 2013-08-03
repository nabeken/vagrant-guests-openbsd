module VagrantPlugins
  module GuestOpenBSD
    module Cap
      class ChangeHostName
        def self.change_host_name(machine, name)
          if !machine.communicate.test("[ `hostname -f` = #{name} ] || [ `hostname -s` = #{name} ]")
            machine.communicate.sudo("su -m root -c 'echo #{name} > /etc/myname'")
            machine.communicate.sudo("hostname #{name}")
          end
        end
      end
    end
  end
end
