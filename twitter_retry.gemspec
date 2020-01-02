# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "twitter_retry/version"

Gem::Specification.new do |spec|
  spec.name          = "twitter_retry"
  spec.version       = TwitterRetry::VERSION
  spec.authors       = ["sue445"]
  spec.email         = ["sue445@sue445.net"]

  spec.summary       = "Twitter api awesome handling with retry"
  spec.description   = "Twitter api awesome handling with retry"
  spec.homepage      = "https://github.com/sue445/twitter_retry"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport"
  spec.add_dependency "twitter"

  spec.add_development_dependency "bundler", ">= 1.10"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "rake", ">= 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-parameterized"
  spec.add_development_dependency "yard"
end
