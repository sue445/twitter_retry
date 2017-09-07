describe TwitterRetry::Retryable do
  describe "#retryable?" do
    subject { TwitterRetry.retryable?(error) }

    before do
      TwitterRetry.config.retryable_errors += [[Twitter::Error::ServiceUnavailable, /something/]]
    end

    context "When can retry error" do
      using RSpec::Parameterized::TableSyntax

      where(:error_class, :message) do
        Twitter::Error::ServiceUnavailable  | "Over capacity"
        Twitter::Error::InternalServerError | "Internal error"
        Twitter::Error                      | "getaddrinfo: Name or service not known"
        Twitter::Error::ServiceUnavailable  | "Sorry, something wrong"
      end

      with_them do
        let(:error) { error_class.new(message) }

        it { should be true }
      end
    end

    context "When can not retry error" do
      using RSpec::Parameterized::TableSyntax

      where(:error_class, :message) do
        Twitter::Error::ServiceUnavailable  | "huga"
        Twitter::Error::InternalServerError | "huga"
        Twitter::Error                      | "core dump!"
        Twitter::Error::ServiceUnavailable  | "anything"
      end

      with_them do
        let(:error) { error_class.new(message) }

        it { should be false }
      end
    end
  end

  describe "#with_handing" do
    subject do
      TwitterRetry.with_handing do
        twitter.follow
      end
    end

    let(:twitter) { double("twitter") }

    let(:over_capacity_error) { Twitter::Error::ServiceUnavailable.new("Over capacity") }
    let(:ignorable_error)     { Twitter::Error::Forbidden.new("Status is a duplicate.") }

    context "When caused Forbidden error" do
      before do
        allow(twitter).to receive(:follow).and_raise(ignorable_error)
      end

      it "should be called follow API with error ignore" do
        expect(twitter).to receive(:follow)
        is_expected.to be false
      end
    end

    context "When successful 4th called wiht Over capacity" do
      before do
        @follow_count = 1
        allow(twitter).to receive(:follow) do
          if @follow_count <= 3
            @follow_count += 1
            raise over_capacity_error
          end

          # 4th successful
        end
      end

      it "should be called follow API" do
        expect(twitter).to receive(:follow)
        is_expected.to be true
      end
    end

    context "When error occurs 4 times in a row" do
      before do
        allow(twitter).to receive(:follow).and_raise(over_capacity_error)
      end

      it "should raise RetryOverError" do
        expect { subject }.to raise_error TwitterRetry::RetryOverError
      end
    end
  end
end
