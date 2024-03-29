module TwitterRetry
  module Retryable
    # retry when error occurred matched with {TwitterRetry::Config#retryable_errors}
    # @return [true]  successful
    # @return [false] error is ignored (ex. `Twitter::Error::Forbidden`)
    # @raise [SuspendedError]
    # @raise [RetryOverError] retried {TwitterRetry::TwitterRetry#max_retry_count} count, but all failure
    # @raise [CannotRetryableError]
    def with_handing
      retry_count = 0

      begin
        yield

      rescue => error
        return false               if ignorable?(error)
        raise SuspendedError       if suspended?(error)
        raise CannotRetryableError unless retryable?(error)
        raise RetryOverError       unless retry_count < TwitterRetry.config.max_retry_count

        retry_count += 1
        sleep(TwitterRetry.config.sleep_second)
        retry
      end

      # successful
      true
    end

    # whether retryable error
    # @param error [Exception]
    def retryable?(error)
      match_any_error?(error, TwitterRetry.config.retryable_errors)
    end

    # whether ignorable error
    # @param error [Exception]
    def ignorable?(error)
      match_any_error?(error, TwitterRetry.config.ignorable_errors)
    end

    # whether suspended user error
    def suspended?(error)
      error.is_a?(Twitter::Error::Forbidden) &&
        error.message.include?("Your account is suspended and is not permitted to access this feature.")
    end

    private

    def match_any_error?(source_error, check_errors)
      check_errors.any? do |error_class, message|
        match_error?(source_error, error_class, message)
      end
    end

    def match_error?(source_error, error_class, message)
      return false unless source_error.is_a?(error_class)

      # Check only error class
      return true unless message

      if message.is_a?(Regexp)
        source_error.message =~ message
      else
        source_error.message.include?(message)
      end
    end
  end
end
