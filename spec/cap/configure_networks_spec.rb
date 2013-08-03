require 'vagrant-guests-openbsd/cap/configure_networks'
require 'spec_helper'

describe VagrantPlugins::GuestOpenBSD::Cap::ConfigureNetworks do
  include_context 'machine'

  it "should configure networks using hostname.in(5)" do
    networks = [
      {:type => :static, :ip => '192.168.10.10', :netmask => '255.255.255.0', :interface => 1},
      {:type => :dhcp, :interface => 2},
      {:type => :static, :ip => '10.168.10.10', :netmask => '255.255.0.0', :interface => 3},
    ]
    communicate.should_receive(:sudo).with("[ -f /etc/hostname.em0 ] && mv /etc/hostname.em0 /tmp")
    communicate.should_receive(:sudo).with("rm /etc/hostname.em* || :")
    communicate.should_receive(:sudo).with("[ -f /tmp/hostname.em0 ] && mv /tmp/hostname.em0 /etc")

    communicate.should_receive(:sudo).with(
      "su -m root -c 'echo inet #{networks[0][:ip]} #{networks[0][:netmask]} > /etc/hostname.em#{networks[0][:interface]}'")
    communicate.should_receive(:sudo).with("sh /etc/netstart em#{networks[0][:interface]}")
    communicate.should_receive(:sudo).with(
      "su -m root -c 'echo dhcp > /etc/hostname.em#{networks[1][:interface]}'")
    communicate.should_receive(:sudo).with("sh /etc/netstart em#{networks[1][:interface]}")
    communicate.should_receive(:sudo).with(
      "su -m root -c 'echo inet #{networks[2][:ip]} #{networks[2][:netmask]} > /etc/hostname.em#{networks[2][:interface]}'")
    communicate.should_receive(:sudo).with("sh /etc/netstart em#{networks[2][:interface]}")

    described_class.configure_networks(machine, networks)
  end
end
