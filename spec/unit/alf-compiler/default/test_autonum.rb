require 'compiler_helper'
module Alf
  class Compiler
    describe Default, "autonum" do

      subject{
        compiler.call(expr)
      }

      let(:expr){
        autonum(an_operand(leaf), :foo)
      }

      it_should_behave_like "a traceable compiled"

      it 'is an Autonum cog' do
        expect(subject).to be_kind_of(Engine::Autonum)
      end

      it 'has the correct autonum attribute name' do
        expect(subject.as).to eq(:foo)
      end

      it 'has the correct sub-cog' do
        expect(subject.operand).to be(leaf)
      end

    end
  end
end
