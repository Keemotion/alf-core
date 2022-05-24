require 'spec_helper'
module Alf
  module Engine
    describe Wrap do

      let(:input) {[
        {:a => "a", :b => "b", :c => "c"},
      ]}

      let(:expected) {[
        {:wrapped => {:a => "a", :b => "b"}, :c => "c"}
      ]}

      it "should wrap as expected" do
        wrap = Wrap.new(input, AttrList[:a, :b], :wrapped, false)
        expect(wrap.to_a).to eq(expected)
      end

      it "should support allbut wrapping" do
        wrap = Wrap.new(input, AttrList[:c], :wrapped, true)
        expect(wrap.to_a).to eq(expected)
      end

    end
  end
end
