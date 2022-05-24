require 'compiler_helper'
module Alf
  class Compiler
    describe Default, "generator" do

      subject{
        compiler.call(expr)
      }

      let(:expr){
        generator(100, :foo)
      }

      it_should_behave_like "a traceable compiled"

      it 'is a Generator cog' do
        expect(subject).to be_kind_of(Engine::Generator)
      end

      it 'has the correct generator attribute name' do
        expect(subject.as).to eq(:foo)
      end

      it 'has the correct generator count' do
        expect(subject.count).to eq(100)
      end

    end
  end
end
