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

    # Some users needs extras along with them
    # 
    # In this exameple, a user needs a set of email message objects attached to them.
    # Instead of using email fixtures, we define the needed mock class and attach
    # them to the user object.
    factory :user_with_mail do
      after(:create) do |user|
        # Add some messages to our user
        (1..10).collect { |number| User.message << MockMessage.new(body: "Message number #{number}") }
      end
    end

  end
end

class MockMessage
  
  attr_accessor :body

  def init opts={}
    @body = opts[:body]
  end

end
