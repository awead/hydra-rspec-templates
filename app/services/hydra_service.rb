# frozen_string_literal: true
class HydraService
  def self.run(parameter)
    new(parameter).run
  end

  attr_accessor :parameter

  def initialize(parameter)
    @parameter = parameter
  end

  def run
    another_method
    "I did it!"
  end

  private

    def another_method
      # etc...
    end
end
