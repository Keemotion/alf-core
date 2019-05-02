require 'spec_helper'
module Alf
  describe AttrList, "hash and ==" do

    subject{ left == right }

    after do
      left.hash.should eq(right.hash) if subject
    end

    context "when the same empty lists" do
      let(:left){ AttrList[] }
      let(:right){ AttrList[] }

      it{ should be_truthy }
    end

    context "when the same lists in same order" do
      let(:left){ AttrList[:a, :b] }
      let(:right){ AttrList[:a, :b] }

      it{ should be_truthy }
    end

    context "when the same lists in different order" do
      let(:left){ AttrList[:a, :b] }
      let(:right){ AttrList[:b, :a] }

      it{ should be_truthy }
    end

    context "when not the same lists" do
      let(:left){ AttrList[:a, :b] }
      let(:right){ AttrList[:b, :c] }

      it{ should be_falsey }
    end

    context "when disjoint" do
      let(:left){ AttrList[:a, :b] }
      let(:right){ AttrList[:c, :d] }

      it{ should be_falsey }
    end

  end
end
