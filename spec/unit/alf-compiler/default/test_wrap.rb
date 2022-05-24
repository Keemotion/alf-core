require 'compiler_helper'
module Alf
  class Compiler
    describe Default, "wrap" do

      subject{
        compiler.call(expr)
      }

      let(:expr){
        wrap(an_operand(leaf), [:foo, :bar], :baz, allbut: true)
      }

      it_should_behave_like "a traceable compiled"

      it 'has a Wrap cog' do
        expect(subject).to be_kind_of(Engine::Wrap)
      end

      it 'has the correct wrapping' do
        expect(subject.attributes).to eq(AttrList[:foo, :bar])
      end

      it 'has the correct as' do
        expect(subject.as).to eq(:baz)
      end

      it 'has the correct allbut' do
        expect(subject.allbut).to be_truthy
      end

      it 'has the correct sub-cog' do
        expect(subject.operand).to be(leaf)
      end

    end
  end
end
