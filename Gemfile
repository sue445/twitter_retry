source "https://rubygems.org"

# Specify your gem's dependencies in twitter_retry.gemspec
gemspec

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.2.2")
  # NOTE: activesupport 5.x supports only ruby 2.2.2+
  gem "activesupport", "< 5.0.0"
end

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.5.0")
  # NOTE: unparser v0.3.0+ requires Ruby 2.5+
  gem "unparser", "< 0.3.0"
end

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create("2.7.0")
  # term-ansicolor 1.9.0+ doesn't work on Ruby < 2.7
  gem "term-ansicolor", "< 1.9.0"
end
