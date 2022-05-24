require 'spec_helper'
module Alf
  class Aggregator
    describe Count do

      it 'should work when used standalone' do
        expect(Count.new.aggregate([])).to eq(0)
        expect(Count.new.aggregate([{}])).to eq(1)
      end

      it 'should install factory methods' do
        expect(Aggregator.count).to be_kind_of(Count)
      end

    end
  end
end
