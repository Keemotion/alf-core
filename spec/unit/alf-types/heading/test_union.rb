require 'spec_helper'
module Alf
  describe Heading, "union" do

    let(:h_name){ Heading[:name => String] }
    let(:h_city){ Heading[:city => String] }

    it "should work on empty headings" do
      expect(Heading::EMPTY.union(Heading::EMPTY)).to eq(Heading::EMPTY)
    end

    it "should work with disjoint headings" do
      expect(h_name.union(h_city)).to eq(Heading[:name => String, :city => String])
    end

    it "should be aliased as +" do
      expect((h_name + h_city)).to eq(Heading[:name => String, :city => String])
    end

    it "should work compute supertype on non-disjoint headings" do
      h1 = Heading[:age => Integer, :name => String]
      h2 = Heading[:age => Integer]
      expect((h1 + h2)).to eq(Heading[:age => Integer, :name => String])
    end

    it "should be aliased as join" do
      h1 = Heading[:age => Integer, :name => String]
      h2 = Heading[:age => Integer]
      expect(h1.join(h2)).to eq(Heading[:age => Integer, :name => String])
    end

  end
end
