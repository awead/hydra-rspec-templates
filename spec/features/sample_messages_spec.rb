require 'spec_helper'

describe "A user's messages" do

  before do
    sign_in FactoryGirl.create(:user_with_mail)
  end

  context "on the home page" do

    before do
      visit root_path
    end

    it "should include the most recent message" do
      pending
    end

  end


end
