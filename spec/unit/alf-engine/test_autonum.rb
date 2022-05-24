require 'spec_helper'
module Alf
  module Engine
    describe Autonum do

      it 'should work on an empty operand' do
        expect(Autonum.new([], :autonum).to_a).to eq([])
      end

      it 'should work on a non empty operand' do
        rel = [
          {:name => "Jones"},
          {:name => "Smith"}
        ]
        exp = [
          {:name => "Jones", :autoname => 0},
          {:name => "Smith", :autoname => 1}
        ]
        expect(Autonum.new(rel, :autoname).to_a).to eq(exp)
      end

    end
  end # module Engine
end # module Alf
