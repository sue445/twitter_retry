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

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/master/CHANGELOG.md"
  spec.metadata["documentation_uri"] = "https://sue445.github.io/twitter_retry/"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "twitter"

  spec.add_development_dependency "bundler", ">= 1.10"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "rake", ">= 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-its"
  spec.add_development_dependency "rspec-parameterized"
  spec.add_development_dependency "unparser", ">= 0.4.5"
  spec.add_development_dependency "yard"
end
