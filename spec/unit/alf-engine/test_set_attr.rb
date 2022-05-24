require 'spec_helper'
module Alf
  module Engine
    describe SetAttr do

      it 'should work on an empty operand' do
        expect(SetAttr.new(Leaf.new([]), TupleComputation[{}]).to_a).to eq([])
      end

      it 'should allow implementing UPDATE' do
        rel = Leaf.new [
          {:name => "Jones"},
          {:name => "Smith"}
        ]
        exp = [
          {:name => "JONES"},
          {:name => "SMITH"}
        ]
        comp = TupleComputation[:name => lambda{ name.upcase }]
        expect(SetAttr.new(rel, comp).to_a).to eq(exp)
      end

      it 'should allow implementing EXTEND' do
        rel = Leaf.new [
          {:name => "Jones"},
          {:name => "Smith"}
        ]
        exp = [
          {:name => "Jones", :up => "JONES"},
          {:name => "Smith", :up => "SMITH"}
        ]
        comp = TupleComputation[:up => lambda{ name.upcase }]
        expect(SetAttr.new(rel, comp).to_a).to eq(exp)
      end

      it 'should support lambda of arity 1' do
        rel = Leaf.new [
          {:name => "Jones"},
          {:name => "Smith"}
        ]
        exp = [
          {:name => "Jones", :up => "JONES"},
          {:name => "Smith", :up => "SMITH"}
        ]
        comp = TupleComputation[:up => lambda{|t| t.name.upcase }]
        expect(SetAttr.new(rel, comp).to_a).to eq(exp)
      end

    end
  end # module Engine
end # module Alf
