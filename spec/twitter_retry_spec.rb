describe TwitterRetry do
  describe ".configure" do
    it "success" do
      TwitterRetry.configure do |config|
        config.max_retry_count  = 10
        config.sleep_second     = 20
        config.retryable_errors = ["foo"]
        config.ignorable_errors = ["bar"]
      end

      aggregate_failures do
        expect(TwitterRetry.config.max_retry_count).to eq 10
        expect(TwitterRetry.config.sleep_second).to eq 20
        expect(TwitterRetry.config.retryable_errors).to eq ["foo"]
        expect(TwitterRetry.config.ignorable_errors).to eq ["bar"]
      end
    end

    after do
      TwitterRetry.configure do |config|
        config.max_retry_count  = 3
        config.sleep_second     = 1
        config.retryable_errors = TwitterRetry::DEFAULT_RETRYABLE_ERRORS
        config.ignorable_errors = TwitterRetry::DEFAULT_IGNORABLE_ERRORS
      end
    end
  end
end
