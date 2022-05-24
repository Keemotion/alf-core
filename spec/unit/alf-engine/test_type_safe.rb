require 'spec_helper'
module Alf
  module Engine
    describe TypeSafe do

      let(:heading){ Heading.new(name: String, status: Integer) }
      let(:cog){ TypeSafe.new(tuples, TypeCheck.new(heading, false)) }

      context 'when all valid tuples' do
        let(:tuples){
          [ {name: "Smith", status: 20}, {name: "Jones"} ]
        }

        it 'simply let the tuples pass' do
          expect(cog.to_a).to eq(tuples)
        end
      end

      context 'when at least one invalid tuple' do
        let(:tuples){
          [ {name: "Smith", status: 20}, {name: "Jones", status: "40"} ]
        }

        it 'raises a TypeCheckError' do
          expect(lambda{
            cog.to_a
          }).to raise_error(TypeCheckError, /Jones/)
        end
      end

    end
  end # module Engine
end # module Alf
