require 'spec_helper'
require 'vagrant-guests-openbsd/guest'

describe VagrantPlugins::GuestOpenBSD::Guest do
  include_context 'machine'

  it "should be detected with OpenBSD" do
    expect(communicate).to receive(:test).with('[ "$(uname -s)" = "OpenBSD" ]')
    guest.detect?(machine)
  end
end
