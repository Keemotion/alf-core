require 'spec_helper'
module Alf
  class Aggregator
    describe Collect do

      let(:rel){[
        {:qty => 10},
        {:qty => 20},
        {:qty => 30},
        {:qty => 40}
      ]}

      it 'should work when used standalone' do
        expect(Collect.new{ qty }.aggregate([])).to eq([])
        expect(Collect.new{ qty }.aggregate(rel)).to eq([10,20,30,40])
      end

      it 'should install factory methods' do
        expect(Aggregator.collect{ qty }).to be_kind_of(Collect)
        expect(Aggregator.collect{ qty }.aggregate(rel)).to eq([10,20,30,40])
      end

    end
  end
end
