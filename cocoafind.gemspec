# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'cocoafind/version'

Gem::Specification.new do |spec|
  spec.name          = "cocoafind"
  spec.version       = Cocoafind::VERSION
  spec.authors       = ["Denys Telezhkin"]
  spec.email         = ["strangervir@gmail.com"]
  spec.summary       = %q{Write a short summary. Required.}
  spec.description   = %q{Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "aruba"
  spec.add_development_dependency "webmock"

  spec.add_dependency 'faraday', '= 0.8.9'
  spec.add_dependency 'faraday_middleware'
  spec.add_dependency 'hashie'
  spec.add_dependency 'typhoeus'
end
