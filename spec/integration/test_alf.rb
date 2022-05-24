require 'spec_helper'
describe Alf::Core do

  it "has a version number" do
    expect(Alf::Core.const_defined?(:VERSION)).to be_truthy
  end

end
