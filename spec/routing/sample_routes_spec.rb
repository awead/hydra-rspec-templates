# frozen_string_literal: true
require 'rails_helper'

describe "Routes" do
  # If you wanted to include routes from an engine, such as Sufia, you would include them here:
  # routes { Sufia::Engine.routes }

  context "to the home page" do
    it "routes the root url to the catalog controller" do
      expect(get: "/").to route_to(controller: "catalog", action: "index")
    end
  end

  context "for a single object" do
    it "routes to the catalog controller" do
      expect(get: "/catalog/thing").to route_to(controller: "catalog", action: "show", id: "thing")
    end
  end
end
