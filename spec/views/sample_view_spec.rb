require 'spec_helper'

describe "default document view" do

  # A mocked solr document
  let(:document) do
    [ 
      :id => "fake_id",
      Solrizer.solr_name("title", :stored_searchable, type: :string).to_sym => ["Some title"]
    ]
  end

  # We can match the raw html output from the view
  let(:sample_html_output) { "dl-horizontal" }

  before do
    # If the view has an instance variable, use assign:
    # assign(:document, document)
    # otherwise, stub it
    view.stub(:document).and_return(document)
    allow(view).to receive(:blacklight_config).and_return(Blacklight::Configuration.new)
    render template: "catalog/_show_default.html.erb"
  end

  it "should display something" do
    expect(rendered).to match(sample_html_output)
  end

end
