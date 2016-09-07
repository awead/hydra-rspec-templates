# frozen_string_literal: true
require 'rails_helper'

describe CatalogController do
  context "when no one is logged in" do
    describe "#index" do
      it "displays search results" do
        get :index, q: "foo"
        expect(response).to be_success
      end
    end

    describe "#show" do
      let(:item) { create(:public_object) }

      it "displays a record" do
        get :show, id: :item
        expect(response).to be_success
      end

      context "when the item doesn't exist" do
        let(:item) { "missing_item" }

        it "displays a record" do
          get :show, id: :item
          expect(response.status).to eq(404)
        end
      end

      context "when the item is not publicly available" do
        let(:private_item) { create(:private_object) }
        let(:message) { "The following item has been marked private" }

        it "displays the appropriate message" do
          get :show, id: private_item
          expect(response).to be_redirect
          expect(request.flash[:notice]).to eql(message)
        end
      end
    end
  end

  context "with an authenticated user" do
    let(:user) { create(:jill) }

    before do
      sign_in user
    end

    describe "#show" do
      context "when the item is not publicly available" do
        let(:private_item) { create(:private_object) }

        it "displays the item" do
          get :show, id: private_item
          expect(response).to be_success
        end
      end
    end
  end
end
