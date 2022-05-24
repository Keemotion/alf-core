require 'spec_helper'
module Alf
  module Engine
    describe Coerce do

      it 'should work on an empty operand' do
        expect(Coerce.new([], Heading[:price => Float]).to_a).to eq([])
      end

      let(:operand){[
          {:name => "Jones", :price => "12.0"},
          {:name => "Smith", :price => "-10.0"}
      ]}

      it 'should work on a non empty operand' do
        exp = [
          {:name => "Jones", :price => 12.0},
          {:name => "Smith", :price => -10.0}
        ]
        heading = Heading[:name => String, :price => Float]
        expect(Coerce.new(operand, heading).to_a).to eq(exp)
      end

      it 'should not project on the heading' do
        exp = [
          {:name => "Jones", :price => 12.0},
          {:name => "Smith", :price => -10.0}
        ]
        heading = Heading[:price => Float]
        expect(Coerce.new(operand, heading).to_a).to eq(exp)
      end

    end
  end # module Engine
end # module Alf
