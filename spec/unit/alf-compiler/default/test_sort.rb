require 'compiler_helper'
module Alf
  class Compiler
    describe Default, "sort" do

      subject{
        compiler.call(expr)
      }

      let(:ordering){
        Ordering.new([[:a, :asc]])
      }

      shared_examples_for "the expected Sort" do
        it_should_behave_like "a traceable compiled"

        it{ should be_a(Engine::Sort) }
      end

      context 'when the cog is not sorted at all' do
        let(:expr){
          sort(an_operand(leaf), ordering)
        }

        it_should_behave_like "the expected Sort"

        it 'should add a Sort' do
          expect(subject.ordering).to be(ordering)
          expect(subject.operand).to be(leaf)
        end
      end

      context 'when the cog is already sorted' do
        let(:expr){
          sort(sort(an_operand(leaf), subordering), ordering)
        }

        context 'in exact same way' do
          let(:subordering){
            Ordering.new([[:a, :asc]])
          }

          it_should_behave_like "the expected Sort"

          it 'should reuse the cog itself' do
            expect(subject.operand).to be(leaf)
            expect(subject.ordering).to be(subordering)
          end
        end

        context 'in a compatible way' do
          let(:subordering){
            Ordering.new([[:a, :asc], [:b, :desc]])
          }

          it_should_behave_like "the expected Sort"

          it 'should reuse the cog itself' do
            expect(subject.operand).to be(leaf)
            expect(subject.ordering).to be(subordering)
          end
        end

        context 'in a incompatible way' do
          let(:subordering){
            Ordering.new([[:a, :desc]])
          }

          it_should_behave_like "the expected Sort"

          it 'should add a Sort' do
            expect(subject.ordering).to be(ordering)
            expect(subject.operand).to be_kind_of(Engine::Sort)
            expect(subject.operand.ordering).to be(subordering)
          end
        end
      end

    end
  end
end
