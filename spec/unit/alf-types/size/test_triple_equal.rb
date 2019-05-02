require 'spec_helper'
module Alf
  module Types
    describe Size, "===" do

      it 'should recognize 0' do
        (Size === 0).should be_truthy
      end

      it 'should recognize any positive integer' do
        (Size === 10).should be_truthy
      end

      it 'should not recognize negative integers' do
        (Size === -1).should be_falsey
      end

      it 'should not recognize non integers' do
        (Size === 10.0).should be_falsey
        (Size === "12").should be_falsey
      end

    end
  end
end
