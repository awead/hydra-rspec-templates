# frozen_string_literal: true
require 'rails_helper'

describe SamplePresenter do
  let(:user)     { create(:user) }
  let(:ability)  { Ability.new(user) }
  let(:object)   { build(:sample_object) }

  let(:presenter) do
    described_class.new(SolrDocument.new(object.to_solr), ability)
  end

  subject { presenter }

  # If the fields require no addition logic for display, you can simply delegate
  # them to the solr document
  it { is_expected.to delegate_method(:title).to(:solr_document) }

  describe "a special title based on some application logic" do
    its(:special_title) { is_expected.to eq("A specially created title") }
  end
end
