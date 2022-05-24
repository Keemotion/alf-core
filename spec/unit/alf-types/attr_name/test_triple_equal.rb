require 'spec_helper'
module Alf
  describe AttrName, "===" do

    it "should allow normal names" do
      expect((AttrName === :city)).to be_truthy
    end

    it "should allow underscores" do
      expect((AttrName === :my_city)).to be_truthy
    end

    it "should allow numbers" do
      expect((AttrName === :city2)).to be_truthy
    end

    it "should allow question marks and bang" do
      expect((AttrName === :big?)).to be_truthy
      expect((AttrName === :big!)).to be_truthy
    end

    it "should not allow strange attribute names" do
      expect(AttrName === "$$$".to_sym).to be_falsey
    end

  end
end
