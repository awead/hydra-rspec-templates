# frozen_string_literal: true
require 'rails_helper'

describe HydraService do
  let(:parameter) { "a parameter" }

  describe "::run" do
    subject { described_class.run(parameter) }
    it { is_expected.to eq("I did it!") }
  end
end
