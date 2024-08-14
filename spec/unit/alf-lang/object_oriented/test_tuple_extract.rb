require 'spec_helper'
module Alf
  module Lang
    describe ObjectOriented, 'tuple_extract' do

      def subject(&bl)
        rel.extend(ObjectOriented.new(rel))
        rel.tuple_extract(&bl)
      end

      context 'on a singleton' do
        let(:rel)     { [{name: "Jones"}] }
        let(:expected){ Tuple(name: "Jones") }

        it 'returns the tuple' do
          expect(subject).to eq(expected)
        end

        it 'is aliased as tuple!' do
          rel.extend(ObjectOriented.new(rel))
          expect(rel.tuple!).to eq(expected)
        end
      end

      context 'on an empty relation' do
        let(:rel){ [] }

        it 'raises a NoSuchTupleError without block' do
          expect{
            subject
          }.to raise_error(NoSuchTupleError)
        end

        it 'yields if a block' do
          expect(subject{ {id: 12} }).to eq(Tuple(id: 12))
        end
      end

      context 'on a relation with more than one tuple' do
        let(:rel){ [{name: "Jones"}, {name: "Smith"}] }

        it 'raises a NoSuchTupleError' do
          expect{
            subject
          }.to raise_error(NoSuchTupleError)
        end
      end

    end
  end
end
