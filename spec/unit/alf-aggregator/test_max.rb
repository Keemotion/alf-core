require 'spec_helper'
module Alf
  class Aggregator
    describe Max do

      let(:rel){[
        {:qty => 10},
        {:qty => 0}
      ]}

      it 'should work when used standalone' do
        expect(Max.new{ qty }.aggregate([])).to eq(nil)
        expect(Max.new{ qty }.aggregate(rel)).to eq(10)
      end

      it 'should install factory methods' do
        expect(Aggregator.max{ qty }).to be_kind_of(Max)
        expect(Aggregator.max{ qty }.aggregate(rel)).to eq(10)
      end

    end
  end
end
