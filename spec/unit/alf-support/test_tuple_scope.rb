require 'spec_helper'
module Alf
  module Support
    describe TupleScope do

      let(:scope){ TupleScope.new }

      it "should install methods properly" do
        scope.__set_tuple(:hello => "a", :world => "b")
        expect(scope.respond_to?(:hello)).to be_truthy
        expect(scope.respond_to?(:world)).to be_truthy
      end

      it "should behave correctly" do
        scope.__set_tuple(:hello => "a", :world => "b")
        expect(scope.hello).to eq("a")
        expect(scope.world).to eq("b")
        scope.__set_tuple(:hello => "c", :world => "d")
        expect(scope.hello).to eq("c")
        expect(scope.world).to eq("d")
      end

      it "should allow instance evaluating on exprs" do
        scope.__set_tuple(:tested => 1)
        expect(scope.evaluate{ tested < 1 }).to be_falsey
      end

      it "should support an attribute called :path" do
        scope.__set_tuple(:path => 1)
        expect(scope.evaluate{ path < 1 }).to be_falsey
      end

      it "should support calling Tuple and Relation" do
        scope.__set_tuple(:path => 1)
        expect(scope.evaluate{ Tuple(sid: path) }).to eq(Tuple(sid: 1))
        expect(scope.evaluate{ Relation(sid: path) }).to eq(Relation(sid: 1))
      end

      it "should support being converted to Relation" do
        scope.__set_tuple(:path => 1)
        expect(Relation(scope)).to eq(Relation(path: 1))
      end

    end
  end
end
