require 'spec_helper'
module Alf
  class Aggregator
    describe Avg do

      let(:rel){[
        {:qty => 10},
        {:qty => 1}
      ]}

      it 'should work when used standalone' do
        expect(Avg.new{ qty }.aggregate(rel)).to eq(5.5)
      end

      it 'should install factory methods' do
        expect(Aggregator.avg{ qty }).to be_kind_of(Avg)
        expect(Aggregator.avg{ qty }.aggregate(rel)).to eq(5.5)
      end

    end
  end
end
