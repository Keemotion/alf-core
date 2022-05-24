require 'spec_helper'
module Alf
  module Engine
    describe Rename do

      it 'should work on an empty operand' do
        expect(Rename.new([], Renaming[{}]).to_a).to eq([])
      end

      it 'should work on a non empty operand' do
        rel = [
          {:name => "Jones", :city => "London"},
          {:name => "Smith", :city => "Paris"}
        ]
        exp = [
          {:last_name => "Jones", :city => "London"},
          {:last_name => "Smith", :city => "Paris"}
        ]
        expect(Rename.new(rel, Renaming[:name => :last_name]).to_a).to eq(exp)
      end

    end
  end # module Engine
end # module Alf
