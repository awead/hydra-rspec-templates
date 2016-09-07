# frozen_string_literal: true
require 'rails_helper'

describe SampleActor do
  let(:user) { create(:user) }

  context "testing your actor in isolation" do
    # define an actor stack with one actor
    let(:actor) { CurationConcerns::Actors::ActorStack.new(object, user, [described_class]) }

    describe "#create" do
      # the object should be new because you're creating one
      let(:object) { SampleObject.new }

      # what's in the parameters hash at the time the actor is called
      let(:parameters) { { field: "value", some_other_field: ["value", "foo"] } }

      it "performs some actions" do
        actor.create(parameters)
        # write your expectations here
      end
    end

    describe "#update" do
      # we're updating an existing object, so let's create one that it's a state
      # that we'd like the actor to do something with. To do this, we can use the
      # FactoryGirl :trait method to set some values on our object that the actor
      # can work with.
      let(:object) { create(:sample_object, :sample_actor_state) }

      # what's in the parameters hash at the time the actor is called
      let(:parameters) { { field: "value", some_other_field: ["value", "foo"] } }

      it "performs some actions" do
        actor.update(parameters)
        # write your expectations here
      end
    end
  end

  context "testing your actor with other actors" do
    let(:actor) { CurationConcerns::Actors::ActorStack.new(object, user, [described_class, AnotherActor]) }

    # etc... Now when you call .update or .create, the actions of all the actors in the stack will be called
    # in the order they are in the array.
  end
end
