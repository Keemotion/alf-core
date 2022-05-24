require 'spec_helper'
module Alf
  module Support
    describe TupleScope, "evaluate" do

      context 'with a simple TupleScope' do
        let(:scope){ TupleScope.new(:a => 1, :b => 2) }

        it "should allow a block" do
          expect(scope.evaluate{ a }).to eq(1)
        end

        it 'should resolve DUM and DEE correctly' do
          expect(scope.evaluate{ DUM }).to be_kind_of(Relation)
        end
      end

      context 'when scopes are added at construction' do
        let(:scope){ TupleScope.new({:who => "world"}, [ HelpersInScope ]) }

        it 'has available helpers in scope' do
          expect(scope.evaluate{ hello(who) }).to eq("Hello world!")
        end
      end

      context 'when scope has a parent' do
        let(:parent){ Scope.new [ HelpersInScope ] }
        let(:scope){ TupleScope.new({:here => "here"}, [  ], parent) }

        it 'has parent helpers in scope' do
          expect(scope.evaluate{ hello(here) }).to eq("Hello here!")
        end
      end

    end
  end
end
