# frozen_string_literal: true
require 'rails_helper'

describe SampleJob do
  let(:param1) { "first parameter" }
  let(:param2) { "second parameter" }
  let(:job)    { described_class.new(param1, param2) }

  describe "#perform" do
    it "does the job" do
      expect(job).to receive(:private_worker)
      expect(job).to receive(:private_worker_with_param).with(param1).and_return("Checking on the work")
      job.perform_now
    end
  end
end
