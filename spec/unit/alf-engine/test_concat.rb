require 'spec_helper'
module Alf
  module Engine
    describe Concat do

      it 'should work on no operand at all' do
        expect(Concat.new([]).to_a).to eq([])
      end

      it 'should work with only one operand' do
        rel = [
          {:name => "Jones"},
          {:name => "Smith"}
        ]
        expect(Concat.new([rel]).to_a).to eq(rel)
      end

      it 'should work with multiple operands' do
        rel = [
          {:name => "Jones"},
          {:name => "Smith"}
        ]
        rel2 = [
          {:name => "Jones"},
          {:name => "Clark"}
        ]
        exp = [
          {:name => "Jones"},
          {:name => "Smith"},
          {:name => "Jones"},
          {:name => "Clark"}
        ]
        expect(Concat.new([rel, rel2]).to_a).to eq(exp)
      end

    end
  end # module Engine
end # module Alf
