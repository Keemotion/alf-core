require 'spec_helper'
module Alf
  module Engine
    describe Sort::InMemory do

      it 'should work on an empty operand' do
        expect(Sort::InMemory.new([], Ordering[[]]).to_a).to eq([])
      end

      it 'should work with ascending' do
        rel = [
          {:name => "Jones"},
          {:name => "Smith"}
        ]
        expect(Sort::InMemory.new(rel, Ordering[[:name, :asc]]).to_a).to eq(rel)
      end

      it 'should work with descending' do
        rel = [
          {:name => "Jones"},
          {:name => "Smith"}
        ]
        exp = [
          {:name => "Smith"},
          {:name => "Jones"}
        ]
        expect(Sort::InMemory.new(rel, Ordering[[:name, :desc]]).to_a).to eq(exp)
      end

    end
  end # module Engine
end # module Alf
