require 'compiler_helper'
module Alf
  class Compiler
    describe Default, "rank" do

      subject{
        compiler.call(expr)
      }

      let(:ordering){
        Ordering.new([[:a, :asc]])
      }

      shared_examples_for "the expected Rank::Cesure" do
        it_should_behave_like "a traceable compiled"

        it 'has a Rank::Cesure cog' do
          expect(subject).to be_kind_of(Engine::Rank::Cesure)
        end

        it 'has the correct parameters' do
          expect(subject.by).to eq(AttrList[:a])
          expect(subject.as).to eq(:foo)
        end
      end

      context 'when not sorted' do
        let(:expr){
          rank(an_operand(leaf), ordering, :foo)
        }

        it_should_behave_like "the expected Rank::Cesure"
        it_should_behave_like "a compiled based on an added sub Sort"
      end

      context 'when already sorted' do
        let(:expr){
          rank(sort(an_operand(leaf), subordering), ordering, :foo)
        }

        context 'in a compatible way' do
          let(:subordering){
            Ordering.new([[:a, :asc], [:b, :desc]])
          }

          it_should_behave_like "the expected Rank::Cesure"
          it_should_behave_like "a compiled reusing a sub Sort"
        end

        context 'in a completely different way' do
          let(:subordering){
            Ordering.new([[:name, :asc]])
          }

          it_should_behave_like "the expected Rank::Cesure"
          it_should_behave_like "a compiled not reusing a sub Sort"
        end

        context 'in incompatible way' do
          let(:subordering){
            Ordering.new([[:a, :desc]])
          }

          it_should_behave_like "the expected Rank::Cesure"
          it_should_behave_like "a compiled not reusing a sub Sort"
        end
      end

    end
  end
end
