# frozen_string_literal: true
class SampleSearchBuilder < Blacklight::SearchBuilder
  self.default_processor_chain += [
    :my_additional_search_criteria
  ]

  # Adds an additional filter query to our search
  def my_additional_search_criteria(solr_parameters)
    solr_parameters[:fq] ||= []
    solr_parameters[:fq] += ["my_field_sim:Term"]
  end
end
