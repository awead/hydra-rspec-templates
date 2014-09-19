require 'spec_helper'

describe "my object model" do

  subject { "an instance of MyObjectModel" }

  context "when it is first created" do
    it "should have a descMetadata datastream" do
      expect(subject.descMetadata).to be_instance_of MyDescriptiveMetadataDatastream
    end
    it "should have a rightsMetdata datastream" do
      expect(subject.descMetadata).to be_instance_of HydraRightsMetdata
    end
    it "should have binaryData datastream" do
      expect(subject.descMetadata).to be_instance_of MyContentDatastream
    end

    it { is_expected.to respond_to(:title) }
    it { is_expected.to respond_to(:author) }
    it { is_expected.to respond_to(:subject) }
    it { is_expected.to respond_to(:description) }

  end

  context "when it is saved" do

    context "without required attributes" do

      it "should return false" do
        expect(subject.save).to be false
      end

    end

    # Create a fixture object once
    before(:all) do
      # Perform some actions to the object prior to saving
    end

    after(:all) do
      # call .destroy to remove it when you're done
    end


    it "should have a title" do
      skip
    end

    it "should have a depositor" do
      skip
    end

    it "should have some default access rights" do
      skip
    end

    describe "the solr document's fields" do
      subject do
        # call .to_solr.keys on your model
      end
      it { is_expected.to include(Solrizer.solr_name("title", :stored_searchable)) }
      it { is_expected.to include(Solrizer.solr_name("author", :stored_searchable)) }
      it { is_expected.to include(Solrizer.solr_name("subject", :stored_searchable)) }
      it { is_expected.to include(Solrizer.solr_name("description", :stored_searchable)) }

    end

  end

end
