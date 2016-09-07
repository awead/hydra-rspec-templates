# frozen_string_literal: true
require 'rails_helper'

describe CurationConcerns::GenericWorksController do
  subject { described_class }

  describe "::show_presenter" do
    its(:show_presenter) { is_expected.to eq(SamplePresenter) }
  end

  describe "::curation_concern_type" do
    its(:curation_concern_type) { is_expected.to eq(SampleObject) }
  end
end
