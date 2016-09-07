# frozen_string_literal: true
require 'rails_helper'

describe "A user's messages" do
  let(:user) { create(:user, :with_mail) }

  context "on the home page" do
    before do
      sign_in(user)
      visit(root_path)
    end

    it "includes the most recent message" do
      pending
    end
  end
end
