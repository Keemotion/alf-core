require 'spec_helper'
module Alf
  module Engine
    describe Compact::Uniq do

      it 'should work on an empty operand' do
        expect(Compact::Uniq.new([]).to_a).to eq([])
      end

      it 'should work when no duplicate is present' do
        rel = [
          {:name => "Jones"},
          {:name => "Smith"}
        ]
        expect(Compact::Uniq.new(rel).to_a).to eq(rel)
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
        expect(Compact::Uniq.new(rel).to_a).to eq(exp)
      end

    end
  end # module Engine
end # module Alf
