# frozen_string_literal: true
require 'rails_helper'

describe SampleForm do
  let(:ability) { nil }
  let(:object)  { build(:sample_object) }

  describe "::terms" do
    subject { described_class }
    its(:terms) { is_expected.to contain_exactly(:this, :that) }
  end

  describe "::required_fields" do
    subject { described_class }
    its(:required_fields) { is_expected.to contain_exactly(:this) }
  end

  # To test instance methods:
  subject { described_class.new(object, ability) }
end
