require 'vagrant-guests-openbsd/cap/mount_nfs_folder'
require 'spec_helper'

describe VagrantPlugins::GuestOpenBSD::Cap::MountNFSFolder do
  include_context 'machine'

  it "should mount nfs folders" do
    ip = "192.168.1.1"
    folders = {
      'folder1' => {:guestpath => '/guest1', :hostpath => '/host1'},
      'folder2' => {:guestpath => '/guest2', :hostpath => '/host2'}
    }
    folders.each do |name, opts|
      communicate.should_receive(:sudo).with("mkdir -p #{opts[:guestpath]}")
      communicate.should_receive(:sudo).with("mount '#{ip}:#{opts[:hostpath]}' '#{opts[:guestpath]}'")
    end
    described_class.mount_nfs_folder(machine, ip, folders)
  end
end
