require 'compiler_helper'
module Alf
  class Compiler
    describe Default, "summarize" do

      subject{
        compiler.call(expr)
      }

      let(:by){
        AttrList[:a]
      }

      let(:summarization){
        Summarization[{ max: Aggregator.max{ qty } }]
      }

      let(:expr){
        summarize(an_operand(leaf), by, summarization, allbut: allbut)
      }

      shared_examples_for "the expected Summarize" do
        it_should_behave_like "a traceable compiled"

        it 'has a Summarize' do
          expect(subject).to be_kind_of(Engine::Summarize)
        end

        it 'has correct parameters' do
          expect(subject.by).to eq(by)
          expect(subject.summarization).to eq(summarization)
          expect(subject.allbut).to eq(allbut)
        end
      end

      context 'when allbut' do
        let(:allbut){ true }

        it 'has a Summarize::Hash' do
          expect(subject).to be_kind_of(Engine::Summarize::Hash)
        end

        it_should_behave_like "the expected Summarize"

        it 'has correct sub-cog' do
          expect(subject.operand).to be(leaf)
        end
      end

      context 'when not allbut' do
        let(:allbut){ false }
        let(:ordering){
          Ordering.new([[:a, :asc]])
        }

        context 'when not already ordered' do
          it 'has a Summarize::Cesure' do
            expect(subject).to be_kind_of(Engine::Summarize::Cesure)
          end

          it_should_behave_like "the expected Summarize"
          it_should_behave_like "a compiled based on an added sub Sort"
        end

        context 'when already in good direction' do
          let(:expr){
            summarize(sort(an_operand(leaf), subordering), by, summarization, allbut: allbut)
          }

          let(:subordering){
            Ordering.new([[:a, :asc]])
          }

          it 'has a Summarize::Cesure' do
            expect(subject).to be_kind_of(Engine::Summarize::Cesure)
          end

          it_should_behave_like "the expected Summarize"
          it_should_behave_like "a compiled reusing a sub Sort"
        end
      end

    end
  end
end
