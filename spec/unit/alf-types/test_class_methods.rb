require 'spec_helper'
module Alf
  describe Types do
    include Types

    describe "common_super_type" do

      it 'works on same types' do
        expect(common_super_type(String, String)).to eq(String)
      end

      it 'works with related types' do
        expect(common_super_type(Integer, Integer)).to eq(Integer)
        expect(common_super_type(Integer, Float)).to eq(Numeric)
      end

      it 'works with true/false/boolean classes' do
        expect(common_super_type(TrueClass, FalseClass)).to eq(Boolean)
        expect(common_super_type(TrueClass, Boolean)).to eq(Boolean)
        expect(common_super_type(Boolean, TrueClass)).to eq(Boolean)
        expect(common_super_type(Boolean, Boolean)).to eq(Boolean)
      end

      it 'fallbacks to Object' do
        expect(common_super_type(Integer, String)).to eq(Object)
      end

      it 'works nicely on same relation types' do
        left  = Relation[pid: String]
        right = Relation[pid: String]
        expect(common_super_type(left, right)).to eq(left)
      end

      it 'works nicely on compatible relation types' do
        left  = Relation[pid: Integer]
        right = Relation[pid: Integer]
        expect(common_super_type(left, right)).to eq(right)
      end

      it 'works nicely on same tuple types' do
        left  = Tuple[pid: String]
        right = Tuple[pid: String]
        expect(common_super_type(left, right)).to eq(left)
      end

      it 'works nicely on compatible relation types' do
        left  = Tuple[pid: Integer]
        right = Tuple[pid: Integer]
        expect(common_super_type(left, right)).to eq(right)
      end

      it 'fallbacks to Tuple when tuple types do not agree' do
        left  = Tuple[pid: String]
        right = Tuple[{}]
        expect(common_super_type(left, right)).to eq(Tuple)
      end

      it 'fallbacks to Relation when relation types do not agree' do
        left  = Relation[pid: String]
        right = Relation[{}]
        expect(common_super_type(left, right)).to eq(Relation)
      end
    end

  end # describe Types
end # module Alf
