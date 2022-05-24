require 'spec_helper'
module Alf
  module Engine
    describe Aggregate do

      it 'should work on an empty operand' do
        expect(Autonum.new(Leaf.new([]), Summarization[{}]).to_a).to eq([])
      end

      it 'should work on a non empty operand' do
        rel = Leaf.new [
          {:name => "Jones", :price => 12.0, :id => 1},
          {:name => "Smith", :price => 10.0, :id => 2}
        ]
        agg = Summarization[:size  => Aggregator.count,
                            :total => Aggregator.sum{|t| t.price }]
        exp = [
          {:size => 2, :total => 22.0}
        ]
        expect(Aggregate.new(rel, agg).to_a).to eq(exp)
      end

    end
  end # module Engine
end # module Alf

