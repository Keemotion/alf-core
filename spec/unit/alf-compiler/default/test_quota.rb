require 'compiler_helper'
module Alf
  class Compiler
    describe Default, "quota" do

      subject{
        compiler.call(expr)
      }

      let(:summarization){
        Summarization[{ max: Aggregator.max{ qty } }]
      }

      let(:ordering){
        Ordering.new([[:b, :asc]])
      }

      shared_examples_for "the expected Quota::Cesure" do
        it_should_behave_like "a traceable compiled"

        it 'has a Quota::Cesure cog' do
          expect(subject).to be_kind_of(Engine::Quota::Cesure)
        end

        it 'has the correct parameters' do
          expect(subject.by).to eq(AttrList[:a])
          expect(subject.summarization).to be(summarization)
        end
      end

      context 'when not sorted' do
        let(:expr){
          quota(an_operand(leaf), [:a], ordering, summarization)
        }

        it_should_behave_like "the expected Quota::Cesure"

        it 'has a Sort as sub-cog' do
          expect(subject.operand).to be_kind_of(Engine::Sort)
          expect(subject.operand.ordering).to eq(Ordering.new([[:a, :asc], [:b, :asc]]))
        end

        it 'has the leaf has sub-sub cog' do
          expect(subject.operand.operand).to be(leaf)
        end
      end

      context 'when already sorted' do
        let(:expr){
          quota(sort(an_operand(leaf), subordering), [:a], ordering, summarization)
        }

        context 'in a compatible way' do
          let(:subordering){
            Ordering.new([[:a, :asc], [:b, :asc]])
          }

          it_should_behave_like "the expected Quota::Cesure"
          it_should_behave_like "a compiled reusing a sub Sort"
        end

        context 'in an incompatible way' do
          let(:subordering){
            Ordering.new([[:a, :desc], [:b, :asc]])
          }

          it_should_behave_like "the expected Quota::Cesure"

          it 'has a Sort as sub-cog' do
            expect(subject.operand).to be_kind_of(Engine::Sort)
            expect(subject.operand.ordering).to eq(Ordering.new([[:a, :asc], [:b, :asc]]))
          end

          it 'has a Sort as sub-sub-cog' do
            expect(subject.operand.operand).to be_kind_of(Engine::Sort)
            expect(subject.operand.operand.ordering).to be(subordering)
          end

          it 'has the leaf has sub-sub-sub cog' do
            expect(subject.operand.operand.operand).to be(leaf)
          end
        end

      end

    end
  end
end
