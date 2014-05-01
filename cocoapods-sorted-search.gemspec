# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "cocoapods-sorted-search"
  spec.version       = '0.2.3'
  spec.authors       = ["Denys Telezhkin"]
  spec.email         = ["strangervir@gmail.com"]
  spec.summary       = %q{CocoaPods plugin for sorted searching amongst CocoaPods.}
  spec.description   = %q{Sort CocoaPods search results by amount of stars, forks, or commit activity!}
  spec.homepage      = "https://github.com/DenHeadless/cocoapods-sorted-search"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'cocoapods', '>= 0.28'
  spec.add_dependency 'ruby-progressbar'
  spec.add_dependency "typhoeus"
  spec.add_dependency "hashie"
  spec.add_dependency "osx_keychain"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
end
