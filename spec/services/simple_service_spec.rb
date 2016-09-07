# frozen_string_literal: true
require 'rails_helper'

describe SimpleService do
  let(:parameter) { "a parameter" }

  describe "::call" do
    subject { described_class.call(parameter) }
    it { is_expected.to eq("I did it!") }
  end
end
