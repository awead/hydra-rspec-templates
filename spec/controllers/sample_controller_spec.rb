require 'spec_helper'

describe CatalogController do

  context "when no one is logged in" do

    describe "#index" do
      it "should display search results" do
        get :index, { q: "foo" }
        expect(response).to be_success
      end
    end

    describe "#show" do

      # Create an ActiveFedora object with public access
      let(:item) { public_object.pid }

      it "should display a record" do
        get :show, { id: :item }
        expect(response).to be_success
      end

      context "when the item doesn't exist" do
        let(:item) { "missing_item" }

        it "should display a record" do
          get :show, { id: :item }
          expect(response.status).to eq(404)
        end
      end

      context "when the item is not publicly available" do
        let(:private_item) { private_object.pid }
        let(:message) { "The following item has been marked private" }

        it "should display the appropriate message" do
          get :show, { id: private_item }
          expect(response).to be_redirect
          expect(request.flash[:notice]).to eql(message)
        end
      end

    end

  end

  context "with an authenticated user" do

    # see support/factory_girl.rb for #find_or_create
    let(:user) { FactoryGirl.find_or_create(:jill) }

    before do
      sign_in user
    end

    describe "#show" do
      context "when the item is not publicly available" do
        let(:private_item) { private_object.pid }

        it "should display the item" do
          get :show, { id: private_item }
          expect(response).to be_success
        end
      end
    end

  end

end
