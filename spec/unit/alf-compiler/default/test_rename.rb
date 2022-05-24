require 'compiler_helper'
module Alf
  class Compiler
    describe Default, "rename" do

      subject{
        compiler.call(expr)
      }

      let(:expr){
        rename(an_operand(leaf), a: :b)
      }

      it_should_behave_like "a traceable compiled"

      it 'has a Rename cog' do
        expect(subject).to be_kind_of(Engine::Rename)
      end

      it 'has the correct rename attributes' do
        expect(subject.renaming).to eq(Renaming[a: :b])
      end

      it 'has the correct sub-cog' do
        expect(subject.operand).to be(leaf)
      end

    end
  end
end
