# frozen_string_literal: true
FactoryGirl.define do
  factory :user do
    # Setup default email and password for each user
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'

    # We might want to refer to a specific user in some of our tests, so we can define them here
    factory :jill do
      email 'jilluser@example.com'
    end

    factory :archivist, aliases: [:user_with_fixtures] do
      email 'archivist1@example.com'
    end

    factory :curator do
      email 'curator1@example.com'
    end
  end

  # Create a user with mail messages
  trait :with_mail do
    after(:create) do |user|
      # Add some messages to our user
      (1..10).collect { |number| user.messages << Mailboxer::Message.new(body: "Message number #{number}") }
    end
  end
end
