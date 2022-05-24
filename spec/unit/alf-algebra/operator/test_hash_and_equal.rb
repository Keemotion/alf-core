require 'spec_helper'
module Alf
  module Algebra
    describe Operator, "hash and ==" do

      let(:foo){
        Operand::Named.new(:foo)
      }

      let(:bar){
        Operand::Named.new(:bar)
      }

      let(:op1){
        a_lispy.restrict(foo, x: 12)
      }

      context '==' do

        it 'recognizes same operands' do
          expect(op1).to eq(op1)
          expect(op1).to eq(a_lispy.restrict(foo, x: 12))
        end

        it 'distinguises other operands' do
          expect(op1).to_not eq(nil)
          expect(op1).to_not eq(a_lispy.restrict(bar, x: 12))
          expect(op1).to_not eq(a_lispy.restrict(foo, x: 13))
        end
      end

      context 'hash' do

        it 'it the same on same operands' do
          expect(op1.hash).to eq(a_lispy.restrict(foo, x: 12).hash)
        end
      end

      context 'using named operands as hash keys' do

        let(:h){
          { op1 => 1,
            a_lispy.restrict(bar, x: 12) => 2 }
        }

        it 'should lead to expected hash' do
          expect(h.size).to eq(2)
        end

        it 'should behave as expected' do
          expect(h[op1]).to eq(1)
          expect(h[a_lispy.restrict(bar, x: 12)]).to eq(2)
          expect(h[a_lispy.restrict(foo, x: 12)]).to eq(1)
        end
      end

    end
  end
end
