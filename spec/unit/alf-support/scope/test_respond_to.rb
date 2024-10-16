require 'spec_helper'
module Alf
  module Support
    describe Scope, 'respond_to?' do

      context 'on an empty Scope' do
        subject{ Scope.new }
        it_behaves_like "A scope"
      end

      context 'on a Scope that has helpers' do
        subject{ Scope.new [ HelpersInScope ] }

        it_behaves_like "A scope"

        it "responds to helpers' methods" do
          expect(subject.respond_to?(:world)).to be_truthy
        end
      end

      context 'on a Scope that has a parent scope' do
        subject{ Scope.new [ ], Scope.new([ HelpersInScope ]) }

        it_behaves_like "A scope"

        it "responds to parent scope methods" do
          expect(subject.respond_to?(:world)).to be_truthy
        end
      end

    end
  end
end
