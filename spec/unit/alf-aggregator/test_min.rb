require 'spec_helper'
module Alf
  class Aggregator
    describe Min do

      let(:rel){[
        {:qty => 10},
        {:qty => 0}
      ]}

      it 'should work when used standalone' do
        expect(Min.new{ qty }.aggregate([])).to eq(nil)
        expect(Min.new{ qty }.aggregate(rel)).to eq(0)
      end

      it 'should install factory methods' do
        expect(Aggregator.min{ qty }).to be_kind_of(Min)
        expect(Aggregator.min{ qty }.aggregate(rel)).to eq(0)
      end

    end
  end
end
