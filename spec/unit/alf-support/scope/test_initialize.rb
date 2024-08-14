require 'spec_helper'
module Alf
  module Support
    describe Scope, 'initialize' do

      it 'supports no argument' do
        expect{ Scope.new }.to_not raise_error
      end

      it 'supports an array of modules' do
        expect{ Scope.new([ Helpers ]) }.to_not raise_error
      end

      it 'supports a parent scope' do
        expect{ Scope.new([ Helpers ], Scope.new) }.to_not raise_error
      end

    end
  end
end
