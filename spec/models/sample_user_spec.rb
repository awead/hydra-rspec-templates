require 'spec_helper'

describe User do

  subject { User.new }

  # Devise should already be testing this so we don't need to do this
  describe "#email" do
    it { is_expected.to respond_to("email") }
  end

  # We've added something extra to User so we do need to test it
  describe "#messages" do
    it { is_expected.to respond_to("messages") }
  end

end
