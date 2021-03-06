require 'spec_helper'
module Alf
  module Support
    describe TupleScope do

      let(:scope){ TupleScope.new }

      it "should install methods properly" do
        scope.__set_tuple(:hello => "a", :world => "b")
        scope.respond_to?(:hello).should be_truthy
        scope.respond_to?(:world).should be_truthy
      end

      it "should behave correctly" do
        scope.__set_tuple(:hello => "a", :world => "b")
        scope.hello.should == "a"
        scope.world.should == "b"
        scope.__set_tuple(:hello => "c", :world => "d")
        scope.hello.should == "c"
        scope.world.should == "d"
      end

      it "should allow instance evaluating on exprs" do
        scope.__set_tuple(:tested => 1)
        scope.evaluate{ tested < 1 }.should be_falsey
      end

      it "should support an attribute called :path" do
        scope.__set_tuple(:path => 1)
        scope.evaluate{ path < 1 }.should be_falsey
      end

      it "should support calling Tuple and Relation" do
        scope.__set_tuple(:path => 1)
        scope.evaluate{ Tuple(sid: path) }.should eq(Tuple(sid: 1))
        scope.evaluate{ Relation(sid: path) }.should eq(Relation(sid: 1))
      end

      it "should support being converted to Relation" do
        scope.__set_tuple(:path => 1)
        Relation(scope).should eq(Relation(path: 1))
      end

    end
  end
end
