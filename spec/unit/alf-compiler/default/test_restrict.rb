require 'compiler_helper'
module Alf
  class Compiler
    describe Default, "restrict" do

      subject{
        compiler.call(expr)
      }

      let(:expr){
        restrict(an_operand(leaf), predicate)
      }

      let(:predicate){
        Predicate.native(->{ true })
      }

      it_should_behave_like "a traceable compiled"

      it 'has a Filter cog' do
        expect(subject).to be_kind_of(Engine::Filter)
      end

      it 'has the correct predicate' do
        expect(subject.predicate).to be(predicate)
      end

      it 'has the correct sub-cog' do
        expect(subject.operand).to be(leaf)
      end

    end
  end
end
