require 'spec_helper'
module Alf
  describe AttrName, "===" do

    it "should allow normal names" do
      (AttrName === :city).should be_truthy
    end

    it "should allow underscores" do
      (AttrName === :my_city).should be_truthy
    end

    it "should allow numbers" do
      (AttrName === :city2).should be_truthy
    end

    it "should allow question marks and bang" do
      (AttrName === :big?).should be_truthy
      (AttrName === :big!).should be_truthy
    end

    it "should not allow strange attribute names" do
      (AttrName === "$$$".to_sym).should be_falsey
    end

  end
end
