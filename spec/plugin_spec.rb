require 'spec_helper'
require 'vagrant-guests-openbsd/plugin'
require 'vagrant-guests-openbsd/cap/change_host_name'
require 'vagrant-guests-openbsd/cap/configure_networks'
require 'vagrant-guests-openbsd/cap/halt'
require 'vagrant-guests-openbsd/cap/mount_nfs_folder'

describe VagrantPlugins::GuestOpenBSD::Plugin do
  [:openbsd, :openbsd_v2].each do |os|
    it "should be loaded with #{os}" do
      expect(described_class.components.guests[os].first).to eq(VagrantPlugins::GuestOpenBSD::Guest)
    end

    {
      :halt               => VagrantPlugins::GuestOpenBSD::Cap::Halt,
      :change_host_name   => VagrantPlugins::GuestOpenBSD::Cap::ChangeHostName,
      :configure_networks => VagrantPlugins::GuestOpenBSD::Cap::ConfigureNetworks,
      :mount_nfs_folder   => VagrantPlugins::GuestOpenBSD::Cap::MountNFSFolder
    }.each do |cap, cls|
      it "should be capable of #{cap} with #{os}" do
        expect(described_class.components.guest_capabilities[os][cap])
          .to eq(cls)
      end
    end
  end
end
