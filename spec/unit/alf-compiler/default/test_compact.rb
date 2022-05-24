require 'compiler_helper'
module Alf
  class Compiler
    describe Default, "compact" do

      subject{
        compiler.call(expr)
      }

      let(:expr){
        compact(an_operand(leaf))
      }

      it_should_behave_like "a traceable compiled"

      it 'has a Compact cog' do
        expect(subject).to be_kind_of(Engine::Compact)
      end

      it 'has the correct sub-cog' do
        expect(subject.operand).to be(leaf)
      end

    end
  end
end
