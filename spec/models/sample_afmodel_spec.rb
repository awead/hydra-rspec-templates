# frozen_string_literal: true
require 'rails_helper'

describe SampleObject do
  # Define the object you're testing using FactoryGirl's build method
  # Prefer build over create because it's faster.
  let(:object) { build(:sample) }

  describe "the object's properties" do
    subject { object }
    it { is_expected.to respond_to(:title) }
    it { is_expected.to respond_to(:author) }
    it { is_expected.to respond_to(:subject) }
    it { is_expected.to respond_to(:description) }
  end

  context "when saving without required attributes" do
    it "returns false" do
      expect(subject.save).to be false
    end
  end

  describe "the object's class properties" do
    subject { described_class }

    # Sufia uses this for display
    its(:human_readable_type) { is_expected.to eq("Sample Object") }

    # If you're using a custom indexer for your model, you can verify it is set
    its(:indexer) { is_expected.to eq(CustomIndexerClass) }
  end

  describe "an example of mocking" do
    # Let's say my model has method called .feeling_lucky? that will return
    # true or false based on some logic somewhere else in the application.
    # I'm not testing the logic here, I just want to know that my model will
    # respond appropriately, so we'll mock the method's response.

    context "when I'm not feeling lucky" do
      before do
        allow(subject).to receive(:feeling_lucky?).and_return(false)
      end
      its(:method_affected_by_luck) { is_expected.to eq("an unlucky outcome") }
    end

    context "when I am feeling lucky" do
      before do
        allow(subject).to receive(:feeling_lucky?).and_return(true)
      end
      its(:method_affected_by_luck) { is_expected.to eq("a lucky outcome") }
    end
  end
end
