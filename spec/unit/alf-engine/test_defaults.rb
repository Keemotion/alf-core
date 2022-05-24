require 'spec_helper'
module Alf
  module Engine
    describe Defaults do

      it 'should work on an empty operand' do
        expect(Defaults.new(Leaf.new([]), TupleComputation[:id => 1]).to_a).to eq([])
      end

      it 'should replace nil by the default value' do
        rel = Leaf.new [
          {:name => "Jones"},
          {:name => nil}
        ]
        exp = [
          {:name => "Jones"},
          {:name => "Smith"}
        ]
        expect(Defaults.new(rel, TupleComputation[:name => "Smith"]).to_a).to eq(exp)
      end

      it 'should add missing attributes and allow computations' do
        rel = Leaf.new [
          {:name => "Jones"},
          {:name => "Smith"}
        ]
        exp = [
          {:name => "Jones", :up => "JONES"},
          {:name => "Smith", :up => "SMITH"}
        ]
        defs = TupleComputation[:up => lambda{ name.upcase }]
        expect(Defaults.new(rel, defs).to_a).to eq(exp)
      end

    end
  end # module Engine
end # module Alf
