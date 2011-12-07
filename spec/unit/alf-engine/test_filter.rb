require 'spec_helper'
module Alf
  module Engine
    describe Filter do

      it 'should work on an empty operand' do
        Filter.new([], TuplePredicate[true]).to_a.should eq([])
      end

      it 'should filter according to the predicate' do
        rel = [
          {:name => "Jones"},
          {:name => "Smith"}
        ]
        exp = [
          {:name => "Jones"},
        ]
        Filter.new(rel, TuplePredicate["name =~ /^J/"]).to_a.should eq(exp)
      end

    end
  end # module Engine
end # module Alf