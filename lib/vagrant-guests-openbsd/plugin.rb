require "vagrant"

module VagrantPlugins
  module GuestOpenBSD
    class Plugin < Vagrant.plugin("2")
      name "OpenBSD guest"
      description "OpenBSD guest support."

      %w{openbsd openbsd_v2}.each do |os|
        guest(os) do
          require_relative "guest"
          Guest
        end

        guest_capability(os, "change_host_name") do
          require_relative "cap/change_host_name"
          Cap::ChangeHostName
        end

        guest_capability(os, "configure_networks") do
          require_relative "cap/configure_networks"
          Cap::ConfigureNetworks
        end

        guest_capability(os, "halt") do
          require_relative "cap/halt"
          Cap::Halt
        end

        guest_capability(os, "mount_nfs_folder") do
          require_relative "cap/mount_nfs_folder"
          Cap::MountNFSFolder
        end
      end
    end
  end
end
