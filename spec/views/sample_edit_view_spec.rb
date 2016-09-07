# frozen_string_literal: true
require 'rails_helper'

describe "sample_edit_view" do
  let(:user)    { create(:user) }
  let(:object)  { build(:sample_object) }
  let(:ability) { double }
  let(:form)    { SampleForm.new(object, ability) }

  before do
    allow(controller).to receive(:current_user).and_return(user)
    assign(:form, form)
    render
  end

  it "renders the form" do
    expect(rendered).to have_content("some content")
  end
end
