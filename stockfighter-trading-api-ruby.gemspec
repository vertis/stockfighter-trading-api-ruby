# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stockfighter/version'

Gem::Specification.new do |spec|
  spec.name          = "stockfighter-trading-api-ruby"
  spec.version       = Stockfighter::VERSION
  spec.authors       = ["Luke Chadwick"]
  spec.email         = ["me@vertis.io"]

  spec.summary       = %q{First pass at a version of a Stockfighter Trading API client for ruby}
  spec.description   = %q{First pass at a version of a Stockfighter Trading API client for ruby}
  spec.homepage      = "https://github.com/vertis-research/stockfighter-trading-api-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  #spec.add_dependency "httparty", "~> 0.13.7"
  spec.add_dependency "typhoeus", "~> 0.8.0"
  spec.add_dependency "faraday", "~> 0.9.2"
  spec.add_dependency "faraday_middleware", "~> 0.10.0"
  spec.add_dependency "websocket-eventmachine-client", "~> 1.1.0"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry", "~> 0.10.3"
  spec.add_development_dependency "rspec", "~> 3.4.0"
  spec.add_development_dependency "vcr", "~> 3.0.0"
  spec.add_development_dependency "webmock", "~> 1.22.3"
end
