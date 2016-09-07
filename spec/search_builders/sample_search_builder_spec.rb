# frozen_string_literal: true
require 'rails_helper'

describe SampleSearchBuilder do
  let(:builder)     { described_class.new([], self) }
  let(:solr_params) { { q: "search terms" } }

  it "adds a filter query to our search" do
    builder.my_additional_search_criteria(solr_params)
    expect(solr_params[:fq]).to contain_exactly("my_field_sim:Term")
  end

  describe "::default_processor_chain" do
    subject { described_class.default_processor_chain }
    it { is_expected.to contain_exactly(:my_additional_search_criteria) }
  end
end
