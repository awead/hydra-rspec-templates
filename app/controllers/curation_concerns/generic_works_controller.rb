# frozen_string_literal: true
# Generated via
#  `rails generate curation_concerns:work GenericWork`

module CurationConcerns
  class GenericWorksController < ApplicationController
    include CurationConcerns::CurationConcernController
    # Adds Sufia behaviors to the controller.
    include Sufia::WorksControllerBehavior

    self.curation_concern_type = SampleObject
    self.show_presenter = SamplePresenter
  end
end
