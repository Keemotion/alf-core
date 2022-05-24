require 'compiler_helper'
module Alf
  class Compiler
    describe Default, "not_matching" do

      subject{
        compiler.call(expr)
      }

      let(:right){
        compact(an_operand(leaf))
      }

      let(:expr){
        not_matching(an_operand(leaf), right)
      }

      it_should_behave_like "a traceable compiled"

      it 'has a Join::Hash cog' do
        expect(subject).to be_kind_of(Engine::Semi::Hash)
      end

      it 'has the correct left sub-cog' do
        expect(subject.left).to be(leaf)
      end

      it 'has the correct right sub-cog' do
        expect(subject.right).to be_kind_of(Engine::Compact)
      end

      it 'has the correct predicate' do
        expect(subject.predicate).to be_falsey
      end

    end
  end
end
