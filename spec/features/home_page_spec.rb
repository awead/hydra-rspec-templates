require 'spec_helper'

describe "The home page" do

  before do
    visit root_path
  end

  context "when no one is logged in" do

    # not sure what's going on? call .save_and_open_page to see
    it "should display some content" do
      save_and_open_page
    end

    # combine multiple tests into one page render to keep tests fast
    it "should display the navigation links" do
      within(".navbar-right") do
        expect(page).to have_link "Bookmarks"
        expect(page).to have_link "History"
      end

    end

  end

end
