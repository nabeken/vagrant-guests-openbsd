require "vagrant"

module VagrantPlugins
  module GuestOpenBSD
    class Plugin < Vagrant.plugin("2")
      name "OpenBSD guest"
      description "OpenBSD guest support."

      config("openbsd") do
        require_relative "config"
        Config
      end

      guest("openbsd") do
        require_relative "guest"
        Guest
      end
    end
  end
end
