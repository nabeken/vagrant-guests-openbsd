require 'vagrant-guests-openbsd/guest'

describe VagrantPlugins::GuestOpenBSD::Guest do
  let(:communicate) {
    double("communicate")
  }
  let(:vm) {
    v = double("vm")
    v.stub(:communicate).and_return(communicate)
    v
  }
  let(:guest) {
    described_class.new(vm)
  }

  it "should halt guest using 'shutdown -hp now'" do
    communicate.should_receive(:sudo).with("shutdown -hp now")
    guest.halt
  end

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
    guest.mount_nfs(ip, folders)
  end

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

    guest.configure_networks(networks)
  end

  it "should change hostname when hostname is differ from current" do
    hostname = 'vagrant-openbsd'
    communicate.stub(:test).and_return(false)
    communicate.should_receive(:sudo).with("su -m root -c 'echo #{hostname} > /etc/myname'")
    communicate.should_receive(:sudo).with("hostname #{hostname}")
    guest.change_host_name(hostname)
  end

  it "should not change hostname when hostname equals current" do
    hostname = 'vagrant-openbsd'
    communicate.stub(:test).and_return(true)
    communicate.should_not_receive(:sudo)
    guest.change_host_name(hostname)
  end
end
