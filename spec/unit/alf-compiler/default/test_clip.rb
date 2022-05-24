require 'compiler_helper'
module Alf
  class Compiler
    describe Default, "clip" do

      subject{
        compiler.call(expr)
      }

      let(:expr){
        clip(an_operand(leaf), [:a])
      }

      it_should_behave_like "a traceable compiled"

      it 'has a Clip cog' do
        expect(subject).to be_kind_of(Engine::Clip)
      end

      it 'has the correct clipping attributes' do
        expect(subject.attributes).to eq(AttrList[:a])
      end

      it 'has the correct sub-cog' do
        expect(subject.operand).to be(leaf)
      end

    end
  end
end
