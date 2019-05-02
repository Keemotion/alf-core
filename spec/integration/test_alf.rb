require 'spec_helper'
describe Alf::Core do

  it "has a version number" do
    Alf::Core.const_defined?(:VERSION).should be_truthy
  end

end
