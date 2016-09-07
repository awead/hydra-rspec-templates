# frozen_string_literal: true
require 'rails_helper'

describe SolrDocument do
  # In most cases, you just want to make sure you've defined a method
  # on your SolrDocument class that matches another field or property
  # you've tested on your model class or in your solr indexer.
  # So a simple response test should be enough:

  it { is_expected.to respond_to(:title) }

  context "when I want to make sure the values are all there" do
    let(:object) { build(:sample_object) }
    subject { described_class.new(object.to_solr) }
    its(:title) { is_expected.to eq("Default title") }
  end
end
