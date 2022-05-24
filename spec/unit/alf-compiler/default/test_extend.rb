require 'compiler_helper'
module Alf
  class Compiler
    describe Default, "extend" do

      subject{
        compiler.call(expr)
      }

      let(:expr){
        extend(an_operand(leaf), computation)
      }

      let(:computation){
        TupleComputation[{ foo: "12" }]
      }

      it_should_behave_like "a traceable compiled"

      it 'has a SetAttr cog' do
        expect(subject).to be_kind_of(Engine::SetAttr)
      end

      it 'has the correct computation' do
        expect(subject.computation).to be(computation)
      end

      it 'has the correct sub-cog' do
        expect(subject.operand).to be(leaf)
      end

    end
  end
end
