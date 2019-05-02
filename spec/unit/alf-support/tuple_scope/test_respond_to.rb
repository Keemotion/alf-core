require 'spec_helper'
module Alf
  module Support
    describe TupleScope, 'respond_to?' do

      context 'on an empty TupleScope' do
        let(:scope){ TupleScope.new }

        it_behaves_like "A scope"

        it 'responds to [], to_s and inspect' do
          scope.respond_to?(:[]).should be_truthy
          scope.respond_to?(:to_s).should be_truthy
          scope.respond_to?(:inspect).should be_truthy
        end
      end

      context 'on a TupleScope that decorates a tuple' do
        let(:scope){ TupleScope.new(:hello => "world") }

        it_behaves_like "A scope"

        it 'responds to tuple keys' do
          scope.respond_to?(:hello).should be_truthy
        end
      end

      context 'on a TupleScope that has helpers' do
        let(:scope){ TupleScope.new(nil, [ HelpersInScope ]) }

        it_behaves_like "A scope"

        it "responds to helpers' methods" do
          scope.respond_to?(:hello).should be_truthy
        end
      end

    end
  end
end
