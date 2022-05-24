require 'spec_helper'
module Alf
  describe Relation, "equality" do

    let(:rel)   { Relation[id: Integer].coerce(id: 12) }
    let(:subrel){ Relation[id:  Integer].coerce(id: 12) }
    let(:suprel){ Relation[id: Numeric].coerce(id: 12) }

    context '==' do

      it 'returns true for all pairs above' do
        expect(rel).to eq(subrel)
        expect(subrel).to eq(rel)
        expect(rel).to eq(suprel)
        expect(suprel).to eq(rel)
        expect(subrel).to eq(suprel)
        expect(suprel).to eq(subrel)
      end

      it 'returns true on empty relations' do
        expect(Relation([])).to eq(Relation([]))
      end

      it 'returns true on empty factored relations' do
        type = Relation[id: Integer]
        expect(type.new(Set.new)).to eq(type.new(Set.new))
      end

      it 'returns true on empty recursively defined relations' do
        type = Relation.type(id: Integer){|r| {children: r} }

        expect(type.new(Set.new)).to eq(type.new(Set.new))

        tuple = {id: 1, children: []}
        expect(type.coerce(tuple)).to eq(type.coerce(tuple))
      end
    end

    context 'eql?' do

      it 'returns true for all pairs' do
        expect(rel).to eql(subrel)
        expect(subrel).to eql(rel)
        expect(rel).to eql(suprel)
        expect(suprel).to eql(rel)
        expect(subrel).to eql(suprel)
        expect(suprel).to eql(subrel)
      end
    end

  end
end
