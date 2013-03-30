# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "vagrant-guests-openbsd"
  spec.version       = "0.0.2"
  spec.authors       = ["TANABE Ken-ichi"]
  spec.email         = ["nabeken@tknetworks.org"]
  spec.description   = %q{Vagrant Guests Plugin for OpenBSD}
  spec.summary       = %q{This plugins allows you to run OpenBSD under vagrant}
  spec.homepage      = "https://github.com/nabeken/vagrant-guests-openbsd"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec-core"
  spec.add_development_dependency "rspec-expectations"
  spec.add_development_dependency "rspec-mocks"
end
