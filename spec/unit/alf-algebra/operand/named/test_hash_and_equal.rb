require 'spec_helper'
module Alf
  module Algebra
    module Operand
      describe Named, "hash and ==" do

        let(:op1){
          Named.new(:foo)
        }

        context '==' do

          it 'recognizes same operands' do
            expect(op1).to eq(op1)
            expect(op1).to eq(Named.new(:foo))
          end

          it 'distinguises other operands' do
            expect(op1).to_not eq(nil)
            expect(op1).to_not eq(Named.new(:foo, :bar))
          end
        end

        context 'hash' do

          it 'it the same on same operands' do
            expect(op1.hash).to eq(Named.new(:foo).hash)
          end
        end

        context 'using named operands as hash keys' do

          let(:h){
            { op1 => 1,
              Named.new(:bar) => 2,
              Named.new(:foo, :bar) => 3 }
          }

          it 'should lead to expected hash' do
            expect(h.size).to eq(3)
          end

          it 'should behave as expected' do
            expect(h[op1]).to eq(1)
            expect(h[Named.new(:foo)]).to eq(1)
            expect(h[Named.new(:foo, :bar)]).to eq(3)
          end
        end

      end
    end
  end
end
