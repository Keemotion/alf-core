require 'spec_helper'
module Alf
  describe AttrList do

    describe "the class itself" do
      let(:type){ AttrList }
      def AttrList.exemplars
        [
          [],
          [:a],
          [:a, :b]
        ].map{|arg| AttrList.coerce(arg) }
      end
      it_should_behave_like 'A valid type implementation'
    end

    describe "coerce" do

      subject{ AttrList.coerce(arg) }

      describe "when passed an AttrList" do
        let(:arg){ AttrList.new [:a, :b] }
        it{ should be(arg) }
      end

      describe "when passed a a list of attribute names as Symbols" do
        let(:arg){ [:a, :b] } 
        it{ should eq(AttrList.new(arg)) }
      end

      describe "when passed an Ordering" do
        let(:arg){ Ordering.new [[:a, :asc], [:b, :asc]] }
        it{ should eq(AttrList.new([:a, :b])) }
      end

      describe "when passed a TupleComputation" do
        let(:arg){ TupleComputation[:a => 12, :b => "Smith"] }
        specify{ 
          subject.should be_a(AttrList) 
          subject.to_a.to_set.should eq([:a, :b].to_set)
        }
      end

      describe "when passed an unrecognized argument" do
        let(:arg){ :not_recognized }
        specify{
          lambda{ subject }.should raise_error(Myrrha::Error)
        }
      end

    end # coerce

    describe "[]" do

      it 'should allow an empty list' do
        AttrList[].should eq(AttrList.new([]))
      end

      it 'should allow an non-empty list' do
        AttrList[:name, :city].should eq(AttrList.new([:name, :city]))
      end

    end # []

    describe "to_ordering" do

      describe "without direction" do
        subject{ AttrList.coerce(attrs).to_ordering }
        let(:attrs){ [:a, :b] }
        it{ should eq(Ordering.new [[:a, :asc], [:b, :asc]])}
      end

      describe "with a direction" do
        subject{ AttrList.coerce(attrs).to_ordering(direction) }
        let(:attrs){ [:a, :b] }
        let(:direction){ :desc }
        it{ should eq(Ordering.new [[:a, :desc], [:b, :desc]])}
      end

    end # to_ordering

    describe "split_tuple" do 

      let(:key){ AttrList.new [:a, :b] }
      let(:tuple){ {:a => 1, :b => 2, :c => 3} }

      describe "when used without allbut" do
        subject{ key.split_tuple(tuple) }
        it{ should eq([{:a => 1, :b => 2}, {:c => 3}]) }
      end

      describe "when used with allbut set to true" do
        subject{ key.split_tuple(tuple, true) }
        it{ should eq([{:c => 3}, {:a => 1, :b => 2}]) }
      end

      describe "when used with allbut set to false" do
        subject{ key.split_tuple(tuple, false) }
        it{ should eq([{:a => 1, :b => 2}, {:c => 3}]) }
      end

      specify "the documentation example" do
        list = AttrList.new([:name])
        tuple = {:name => "Jones", :city => "London"}
        list.split_tuple(tuple).should eq([{:name => "Jones"}, {:city => "London"}])
        list.split_tuple(tuple, true).should eq([{:city => "London"}, {:name => "Jones"}])
      end

    end # split

    describe "project_tuple" do 

      let(:key){ AttrList.new [:a, :b] }
      let(:tuple){ {:a => 1, :b => 2, :c => 3} }

      describe "when used without allbut" do
        subject{ key.project_tuple(tuple) }
        it{ should eq({:a => 1, :b => 2}) }
      end

      describe "when used with allbut set to true" do
        subject{ key.project_tuple(tuple, true) }
        it{ should eq({:c => 3}) }
      end

      describe "when used without allbut set to false" do
        subject{ key.project_tuple(tuple, false) }
        it{ should eq({:a => 1, :b => 2}) }
      end

      specify "the documentation example" do
        list = AttrList.new([:name])
        tuple = {:name => "Jones", :city => "London"}
        list.project_tuple(tuple).should eq({:name => "Jones"})
        list.project_tuple(tuple, true).should eq({:city => "London"})
      end

    end # project

    it 'should to_a' do
      AttrList[:a, :b].to_a.should eq([:a, :b])
      AttrList[].to_a.should eq([])
    end

    it "should define a value" do
      l1 = AttrList.new [:a, :b]
      l2 = AttrList.new [:a, :b]
      l3 = AttrList.new [:a]

      l1.should == l2
      l1.should eq(l2)

      l1.should_not == l3
      l1.should_not eq(l3)

      {l1 => 1, l2 => 2}.size.should eq(1)
    end

  end
end
