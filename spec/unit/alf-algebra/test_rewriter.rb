require 'spec_helper'
module Alf
  module Algebra
    describe Rewriter do

      let(:expr){
        l = a_lispy
        l.project(l.rename(an_operand, :firstname => :name), [:name])
      }

      let(:rewriter){
        Rewriter.new
      }

      subject{ rewriter.call(expr) }

      it 'returns an equal expression' do
        expect(subject).to eq(expr)
      end

      it 'makes a deep copy, up to leaf operands' do
        expect(subject).to_not be(expr)
        expect(subject.operand).to_not be(expr.operand)
        expect(subject.operand.operand).to be(expr.operand.operand)
      end

    end
  end
end
