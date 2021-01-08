describe TwitterRetry::Config do
  let(:config) { TwitterRetry::Config.new }

  describe "get default values" do
    subject { config }

    its(:max_retry_count)  { should eq 3 }
    its(:sleep_second)     { should eq 1 }
    its(:retryable_errors) { should eq TwitterRetry::DEFAULT_RETRYABLE_ERRORS }
    its(:ignorable_errors) { should eq TwitterRetry::DEFAULT_IGNORABLE_ERRORS }
  end

  describe "set and get configs" do
    subject { config }

    before do
      config.max_retry_count  = 10
      config.sleep_second     = 20
      config.retryable_errors = ["foo"]
      config.ignorable_errors = ["bar"]
    end

    its(:max_retry_count)  { should eq 10 }
    its(:sleep_second)     { should eq 20 }
    its(:retryable_errors) { should eq ["foo"] }
    its(:ignorable_errors) { should eq ["bar"] }
  end
end
