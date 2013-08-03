require 'vagrant-guests-openbsd/cap/change_host_name'
require 'spec_helper'

describe VagrantPlugins::GuestOpenBSD::Cap::ChangeHostName do
  include_context 'machine'

  it "should change hostname when hostname is differ from current" do
    hostname = 'vagrant-openbsd'
    communicate.stub(:test).and_return(false)
    communicate.should_receive(:sudo).with("su -m root -c 'echo #{hostname} > /etc/myname'")
    communicate.should_receive(:sudo).with("hostname #{hostname}")
    described_class.change_host_name(machine, hostname)
  end

  it "should not change hostname when hostname equals current" do
    hostname = 'vagrant-openbsd'
    communicate.stub(:test).and_return(true)
    communicate.should_not_receive(:sudo)
    described_class.change_host_name(machine, hostname)
  end
end
