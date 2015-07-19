# TwitterRetry

Twitter api awesome handling with retry

[![Build Status](https://travis-ci.org/sue445/twitter_retry.svg?branch=master)](https://travis-ci.org/sue445/twitter_retry)
[![Code Climate](https://codeclimate.com/github/sue445/twitter_retry/badges/gpa.svg)](https://codeclimate.com/github/sue445/twitter_retry)
[![Coverage Status](https://coveralls.io/repos/sue445/twitter_retry/badge.svg?branch=master&service=github)](https://coveralls.io/github/sue445/twitter_retry?branch=master)
[![Dependency Status](https://gemnasium.com/sue445/twitter_retry.svg)](https://gemnasium.com/sue445/twitter_retry)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'twitter_retry'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install twitter_retry

## Usage
```ruby
TwitterRetry.with_handing do
  # some twitter API code
  twitter.update("some tweet")
end
```

* When `twitter.update` not raise error
  * return `true`
* When `twitter.update` raise `Twitter::Error::Forbidden` (Your account is suspended and is not permitted to access this feature.)
  * raise `TwitterRetry::SuspendedError`
* When `twitter.update` raise ignorable error (ex. `Twitter::Error::Forbidden`(User is over daily status update limit.))
  * error is squashed
  * return `false`
* When `twitter.update` raise retryable error (ex. `Twitter::Error::ServiceUnavailable`(Over capacity))
  * retry 3 times with sleep 1 second
  * When successful in retry, return `true`
  * When all failure, raise `TwitterRetry::RetryOverError`
  
The algorithm is actually more concise in code: See [TwitterRetry::Retryable](lib/twitter_retry/retryable.rb)

## Configuration
```ruby
TwitterRetry.configure do |config|
  config.sleep_second     = 1
  config.max_retry_count  = 3
  config.retryable_errors << [Twitter::Error, "some error message"]
  config.ignorable_errors << [Twitter::Error, "some error message"]
end
```

See [TwitterRetry::Config](lib/twitter_retry/config.rb)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sue445/twitter_retry.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

