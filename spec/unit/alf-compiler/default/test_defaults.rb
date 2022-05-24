require 'compiler_helper'
module Alf
  class Compiler
    describe Default, "defaults" do

      subject{
        compiler.call(expr)
      }

      shared_examples_for 'the expected Defaults' do

        it_should_behave_like "a traceable compiled"

        it 'has a Defaults cog' do
          expect(subject).to be_kind_of(Engine::Defaults)
        end

        it 'has the correct defaults' do
          expect(subject.defaults.to_hash).to eq(b: 1)
        end
      end

      context "when non strict" do
        let(:expr){
          defaults(an_operand(leaf), b: 1)
        }

        it_should_behave_like "the expected Defaults"

        it 'has the correct sub-cog' do
          expect(subject.operand).to be(leaf)
        end
      end

      context "when strict" do
        let(:expr){
          defaults(an_operand(leaf), {b: 1}, strict: true)
        }

        it_should_behave_like "the expected Defaults"

        it 'has a Clip sub-sub cog' do
          expect(subject.operand).to be_kind_of(Engine::Clip)
          expect(subject.operand.attributes).to eq(AttrList[:b])
        end
      end

    end
  end
end
