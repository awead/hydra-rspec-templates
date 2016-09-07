# frozen_string_literal: true
require 'rails_helper'

describe CustomIndexer do
  let(:model)    { build(:sample_model) }

  # The most commonly used method here is .generate_solr_document but you are free to
  # test any others. This will create a hash with keys corresponding to solr fields
  # and the values corresponding to the values for those fields. Ex:
  #  { "field1_tesim" => ["foo", "bar"], "field2_sim" => ["cake"] }
  let(:solr_doc) { described_class.new(model).generate_solr_document }

  it "indexes field1" do
    expect(solr_doc).to include("field1_tesim" => ["foo", "bar"])
  end

  it "adds a facet for 'cake'" do
    expect(solr_doc["field2_sim"]).to include("Cake")
  end
end
