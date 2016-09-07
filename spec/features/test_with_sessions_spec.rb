# frozen_string_literal: true
require 'rails_helper'

describe "Using sessions in a feature test" do
  let(:user) { create(:user) }

  context "using Capybara's default session" do
    before { sign_in(user) }

    it "tests non-js enable content" do
    end
  end

  context "using a the Poltergeist driver" do
    before { sign_in_with_js(user) }

    it "tests javascripte-enabled features" do
    end
  end

  context "using a the Poltergeist driver and allowing errors", js_errors: false do
    before { sign_in_with_js(user) }

    it "tests javascripte-enabled features and ingores errors" do
    end
  end
end
