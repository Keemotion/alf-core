require 'spec_helper'
module Alf
  describe Relation, "aggregation methods" do

    let(:rel){ Alf::Relation(qty: [1, 2, 3, 4]) }

    it "avg" do
      expect(rel.avg{ qty }).to eq(2.5)
    end

    it "collect", :ruby19 => true do
      expect(rel.collect{ qty }).to eq([1, 2, 3, 4])
    end

    it "concat", :ruby19 => true do
      expect(rel.concat{ qty }).to eq("1234")
    end

    it "count" do
      expect(rel.count).to eq(4)
    end

    it "max" do
      expect(rel.max{ qty }).to eq(4)
    end

    it "min" do
      expect(rel.min{ qty }).to eq(1)
    end

    it "sum" do
      expect(rel.sum{ qty }).to eq(10)
    end

  end
end
