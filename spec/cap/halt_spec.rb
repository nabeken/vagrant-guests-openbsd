require 'vagrant-guests-openbsd/cap/halt'
require 'spec_helper'

describe VagrantPlugins::GuestOpenBSD::Cap::Halt do
  include_context 'machine'

  it "should halt guest using 'shutdown -hp now'" do
    communicate.should_receive(:sudo).with("shutdown -hp now")
    described_class.halt(machine)
  end
end
