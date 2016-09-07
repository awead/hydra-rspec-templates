# frozen_string_literal: true
FactoryGirl.define do
  factory :sample_object, aliases: [:sample, :sample_model] do
    factory :private_object do
      # If Hydra access controls are enabled, set visibility
      # visibility Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PRIVATE
    end

    factory :public_object do
      # If Hydra access controls are enabled, set visibility
      # visibility Hydra::AccessControls::AccessRight::VISIBILITY_TEXT_VALUE_PUBLIC
    end
  end

  trait :sample_actor_state do
    # set some properties on our object for our sample actor to work with
  end
end
