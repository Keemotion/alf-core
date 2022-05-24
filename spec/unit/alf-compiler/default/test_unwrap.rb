require 'compiler_helper'
module Alf
  class Compiler
    describe Default, "unwrap" do

      subject{
        compiler.call(expr)
      }

      let(:expr){
        unwrap(an_operand(leaf), :a)
      }

      it_should_behave_like "a traceable compiled"

      it 'has a Unwrap cog' do
        expect(subject).to be_kind_of(Engine::Unwrap)
      end

      it 'has the correct unwrapping attribute' do
        expect(subject.attribute).to eq(:a)
      end

      it 'has the correct sub-cog' do
        expect(subject.operand).to be(leaf)
      end

    end
  end
end
