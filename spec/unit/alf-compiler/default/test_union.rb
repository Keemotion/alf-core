require 'compiler_helper'
module Alf
  class Compiler
    describe Default, "union" do

      subject{
        compiler.call(expr)
      }

      let(:right){
        clip(an_operand(leaf), [:a])
      }

      let(:expr){
        union(an_operand(leaf), right)
      }

      it_should_behave_like "a traceable compiled"

      it 'has a Compact cog' do
        expect(subject).to be_kind_of(Engine::Compact)
      end

      it 'has a Concat sub-cog' do
        expect(subject.operand).to be_kind_of(Engine::Concat)
      end

      it 'has the correct sub-sub-cogs' do
        ops = subject.operand.operands
        expect(ops.first).to be(leaf)
        expect(ops.last).to be_kind_of(Engine::Clip)
      end

    end
  end
end
