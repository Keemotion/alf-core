require 'spec_helper'
module Alf
  class Aggregator
    describe Sum do

      let(:rel){[
        {:qty => 10},
        {:qty => 20}
      ]}

      it 'should work when used standalone' do
        expect(Sum.new{ qty }.aggregate([])).to eq(0)
        expect(Sum.new{ qty }.aggregate(rel)).to eq(30)
      end

      it 'should install factory methods' do
        expect(Aggregator.sum{ qty }).to be_kind_of(Sum)
        expect(Aggregator.sum{ qty }.aggregate(rel)).to eq(30)
      end

    end
  end
end
