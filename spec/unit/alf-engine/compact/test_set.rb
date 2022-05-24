require 'spec_helper'
module Alf
  module Engine
    describe Compact::Set do

      it 'should work on an empty operand' do
        expect(Compact::Set.new([]).to_a).to eq([])
      end

      it 'should work when no duplicate is present' do
        rel = [
          {:name => "Jones"},
          {:name => "Smith"}
        ]
        expect(Compact::Set.new(rel).to_set).to eq(rel.to_set)
      end

      it 'should work when duplicates are present' do
        rel = [
          {:name => "Jones"},
          {:name => "Smith"},
          {:name => "Jones"},
        ]
        exp = [
          {:name => "Jones"},
          {:name => "Smith"}
        ]
        expect(Compact::Set.new(rel).to_set).to eq(exp.to_set)
      end

    end
  end # module Engine
end # module Alf
