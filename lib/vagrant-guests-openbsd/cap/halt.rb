module VagrantPlugins
  module GuestOpenBSD
    module Cap
      class Halt
        def self.halt(machine)
          begin
            machine.communicate.sudo("shutdown -hp now")
          rescue IOError
            # ignore IOError while shutting down
            # See FreeBSD's halt implementation
          end
        end
      end
    end
  end
end
