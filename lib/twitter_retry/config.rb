module TwitterRetry
  require "active_support/configurable"

  DEFAULT_RETRYABLE_ERRORS = [
    [Twitter::Error::ServiceUnavailable,  "Over capacity"],
    [Twitter::Error::InternalServerError, "Internal error"],
    [Twitter::Error,                      "getaddrinfo: Name or service not known"],
  ]

  DEFAULT_IGNORABLE_ERRORS = [
    [Twitter::Error::Forbidden, "Status is a duplicate."],
    [Twitter::Error::Forbidden, "User is over daily status update limit."],
    [Twitter::Error::Forbidden, "This request looks like it might be automated."],
  ]

  class Config
    include ActiveSupport::Configurable

    config_accessor :max_retry_count, :sleep_second
    config_accessor :retryable_errors, :ignorable_errors

    configure do |config|
      config.max_retry_count  = 3
      config.sleep_second     = 1
      config.retryable_errors = DEFAULT_RETRYABLE_ERRORS
      config.ignorable_errors = DEFAULT_IGNORABLE_ERRORS
    end
  end
end
