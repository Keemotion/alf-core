require 'compiler_helper'
module Alf
  class Compiler
    describe Compiler, 'on_hierarchize' do

      subject{
        compiler.call(expr)
      }

      let(:operand){
        an_operand.with_heading(id: Integer, parent: Integer).with_keys([:id])
      }

      let(:expr){
        a_lispy.hierarchize(an_operand(leaf), :id, :parent, :as)
      }

      it_should_behave_like "a traceable compiled"

      it{ should be_a(Engine::Hierarchize) }

      it 'should have correct id list' do
        expect(subject.id).to eq(AttrList[:id])
      end

      it 'should have correct parent list' do
        expect(subject.parent).to eq(AttrList[:parent])
      end

      it 'should have correct children name' do
        expect(subject.children).to eq(:as)
      end

      it 'has the correct sub-cog' do
        expect(subject.operand).to be(leaf)
      end

    end
  end
end
