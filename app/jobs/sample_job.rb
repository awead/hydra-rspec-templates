# frozen_string_literal: true
class SampleJob < ActiveJob::Base
  queue_as :special

  def perform(param1, _param2)
    private_worker
    private_worker_with_param(param1)
    "Doin' the job"
  end

  private

    def private_worker
      "I don't care what happens here"
    end

    def private_worker_with_param(_param1)
      "Checking on the work"
    end
end
