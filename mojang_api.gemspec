# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mojang_api/version'

Gem::Specification.new do |spec|
  spec.name          = "mojang_api"
  spec.version       = MojangApi::VERSION
  spec.authors       = ["downslope7"]
  spec.email         = ["downslope7@lovesyourmom.com"]
  spec.summary       = %q{Mojang UUID/profile API}
  spec.description   = %q{Get Mojang profile information coming from a username or a UUID. Will also read in whitelist data and output whitelists in pre-1.7 and 1.7+ formats.}
  spec.homepage      = "https://github.com/downslope7/mojang_api"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_dependency "httparty"
end
