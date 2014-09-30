require 'spec_helper'

describe "an xml-based datastream" do

  subject { Hydra::Datastream::Properties.new }

  before do
    subject.title = "My Title"
  end

  it "should have attributes" do
    expect(subject.title).to include "My Title"
  end

  let(:xml_fixture) { File.read(File.join(fixture_path, "sample_xml_fixture.xml")) }

  it "should match an existing exemplar" do
    expect(subject.ng_xml).to be_equivalent_to xml_fixture
  end

  context "when solrized" do
    # dsid has to be set to call .to_solr
    let(:solr_document) { Hydra::Datastream::Properties.new(nil, "sample").to_solr }
    specify "the document is empty (by default no fields are solrized)" do
      expect(solr_document).to be_empty
    end
  end

end

describe "an RDF datastream" do

  it "should have attributes" do
    skip "etc..."
  end

  context "when solrized" do
    it "should have the required solr fields" do
      skip "etc..."
    end
  end

end
