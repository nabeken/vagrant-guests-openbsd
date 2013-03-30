require 'vagrant-guests-openbsd/plugin'

describe VagrantPlugins::GuestOpenBSD::Plugin do
  it "should be loaded with openbsd" do
    described_class.guest[:openbsd].should == VagrantPlugins::GuestOpenBSD::Guest
    described_class.components.configs[:top][:openbsd].should == VagrantPlugins::GuestOpenBSD::Config
  end

  it "should be loaded with openbsd_v2" do
    described_class.guest[:openbsd_v2].should == VagrantPlugins::GuestOpenBSD::Guest
    described_class.components.configs[:top][:openbsd_v2].should == VagrantPlugins::GuestOpenBSD::Config
  end
end
