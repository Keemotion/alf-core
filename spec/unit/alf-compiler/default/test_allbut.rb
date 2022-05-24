require 'compiler_helper'
module Alf
  class Compiler
    describe Default, "allbut" do

      subject{
        compiler.call(expr)
      }

      shared_examples_for "a compacted compilation result" do

        it_should_behave_like "a traceable compiled"

        it 'has a Compact cog' do
          expect(subject).to be_kind_of(Engine::Compact)
        end

        it 'has a Clip sub-cog' do
          expect(subject.operand).to be_kind_of(Engine::Clip)
          expect(subject.operand.attributes).to eq(AttrList[:a])
          expect(subject.operand.allbut).to be_truthy
        end

        it 'has the corect sub-sub cog' do
          expect(subject.operand.operand).to be(leaf)
        end
      end

      context 'when keys not available' do
        let(:expr){
          allbut(an_operand(leaf), [:a])
        }

        it_should_behave_like "a compacted compilation result"
      end

      context 'when keys are available and not preserving' do
        let(:expr){
          allbut(an_operand(leaf).with_keys([:a]), [:a])
        }

        it_should_behave_like "a compacted compilation result"
      end

      context 'when keys are available and preserving' do
        let(:expr){
          allbut(an_operand(leaf).with_keys([:b]), [:a])
        }

        it_should_behave_like "a traceable cog"

        it 'has a Clip cog' do
          expect(subject).to be_kind_of(Engine::Clip)
          expect(subject.attributes).to eq(AttrList[:a])
          expect(subject.allbut).to be_truthy
        end

        it 'has the correct sub cog' do
          expect(subject.operand).to be(leaf)
        end
      end

    end
  end
end
