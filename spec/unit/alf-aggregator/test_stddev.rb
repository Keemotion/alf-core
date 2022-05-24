require 'spec_helper'
module Alf
  class Aggregator
    describe Stddev do

      let(:rel){[
        {:qty => 10},
        {:qty => 20},
        {:qty => 30},
        {:qty => 40}
      ]}
      let(:expected) {
        Math.sqrt(Variance.new{qty}.aggregate(rel))
      }

      it 'should work when used standalone' do
        expect(Stddev.new{ qty }.aggregate(rel)).to eq(expected)
      end

      it 'should install factory methods' do
        expect(Aggregator.stddev{ qty }).to be_kind_of(Stddev)
        expect(Aggregator.stddev{ qty }.aggregate(rel)).to eq(expected)
      end

    end
  end
end
