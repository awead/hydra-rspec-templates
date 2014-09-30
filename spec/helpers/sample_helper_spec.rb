require 'spec_helper'

describe ApplicationHelper do

  describe "#sample_helper" do
    subject { helper.sample_helper }
    it { is_expected.to eql("foo") }
  end

end
