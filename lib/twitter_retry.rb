require "twitter"
require "twitter_retry/version"
require "twitter_retry/config"
require "twitter_retry/retryable"

module TwitterRetry
  extend Retryable

  def self.config
    @config ||= Config.new
  end

  def self.configure
    yield config if block_given?
  end

  class BaseError < ::StandardError; end

  class SuspendedError < BaseError; end

  class RetryOverError < BaseError; end

  class CannotRetryableError < BaseError; end
end
