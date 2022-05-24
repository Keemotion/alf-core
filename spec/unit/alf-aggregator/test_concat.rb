require 'spec_helper'
module Alf
  class Aggregator
    describe Concat do

      let(:rel){[
        {:qty => 10},
        {:qty => 20},
        {:qty => 30},
        {:qty => 40}
      ]}

      it 'should work when used standalone' do
        expect(Concat.new{ qty }.aggregate([])).to eq("")
        expect(Concat.new{ qty }.aggregate(rel)).to eq("10203040")
      end

      it 'should work when used standalone with Proc of arity 1' do
        expect(Concat.new{|t| t.qty }.aggregate(rel)).to eq("10203040")
      end

      it 'should work when used standalone with Proc of arity 1 passed as arg' do
        expect(Concat.new(->(t){ t.qty }).aggregate(rel)).to eq("10203040")
      end

      it 'should install factory methods' do
        expect(Aggregator.concat{ qty }).to be_kind_of(Concat)
        expect(Aggregator.concat{ qty }.aggregate(rel)).to eq("10203040")
      end

      it 'should work with options' do
        options = {:before => "bef", :after => "aft", :between => " bet "}
        expected = "bef10 bet 20 bet 30 bet 40aft"
        expect(Aggregator.concat(options){ qty }.aggregate(rel)).to eq(expected)
      end

    end
  end
end
