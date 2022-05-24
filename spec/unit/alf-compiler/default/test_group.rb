require 'compiler_helper'
module Alf
  class Compiler
    describe Default, "group" do

      subject{
        compiler.call(expr)
      }

      let(:expr){
        group(an_operand(leaf), [:foo, :bar], :baz, allbut: true)
      }

      it_should_behave_like "a traceable compiled"

      it 'has a Group cog' do
        expect(subject).to be_kind_of(Engine::Group)
      end

      it 'has the correct grouping' do
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
