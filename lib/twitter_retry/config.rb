module TwitterRetry
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
    # @!attribute max_retry_count
    #   @return [Integer]
    attr_accessor :max_retry_count

    # @!attribute sleep_second
    #   @return [Integer]
    attr_accessor :sleep_second

    # @!attribute retryable_errors
    #   @return [Array<String>]
    attr_accessor :retryable_errors

    # @!attribute ignorable_errors
    #   @return [Array<String>]
    attr_accessor :ignorable_errors

    def initialize
      @max_retry_count  = 3
      @sleep_second     = 1
      @retryable_errors = DEFAULT_RETRYABLE_ERRORS
      @ignorable_errors = DEFAULT_IGNORABLE_ERRORS
    end
  end
end
