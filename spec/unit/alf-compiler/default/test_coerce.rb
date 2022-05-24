require 'compiler_helper'
module Alf
  class Compiler
    describe Default, "coerce" do

      subject{
        compiler.call(expr)
      }

      let(:expr){
        coerce(an_operand(leaf), a: String)
      }

      it_should_behave_like "a traceable compiled"

      it 'has a Coerce cog' do
        expect(subject).to be_kind_of(Engine::Coerce)
      end

      it 'has the correct coercion heading' do
        expect(subject.coercions).to eq(Heading[a: String])
      end

      it 'has the correct sub-cog' do
        expect(subject.operand).to be(leaf)
      end

    end
  end
end
