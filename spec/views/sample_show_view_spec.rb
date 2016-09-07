# frozen_string_literal: true
require 'rails_helper'

describe "a sample view" do
  # Build a sample solr document
  let(:object)   { build(:sample_object, id: '1234') }
  let(:document) { SolrDocument.new(object.to_solr) }

  # We can match the raw html output from the view
  let(:sample_html_output) { "dl-horizontal" }

  before do
    # If the view has an instance variable, use assign:
    # assign(:document, document)
    # otherwise, stub it
    allow(view).to receive(:document).and_return(document)

    # If we have a Blacklight view, we need to add this
    allow(view).to receive(:blacklight_config).and_return(Blacklight::Configuration.new)

    # Finally, render the template we're testing
    render template: "catalog/_show_default.html.erb"
  end

  it "displays something" do
    expect(rendered).to match(sample_html_output)
  end

  context "when there are other partials in the view" do
    # Stub the ones we don't care about or return default content
    before do
      stub_template 'curation_concerns/base/_metadata.html.erb' => ''
    end

    it "displays something" do
      expect(rendered).to match(sample_html_output)
    end
  end
end
