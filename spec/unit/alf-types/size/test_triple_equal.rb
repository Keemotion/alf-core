require 'spec_helper'
module Alf
  module Types
    describe Size, "===" do

      it 'should recognize 0' do
        expect((Size === 0)).to be_truthy
      end

      it 'should recognize any positive integer' do
        expect((Size === 10)).to be_truthy
      end

      it 'should not recognize negative integers' do
        expect(Size === -1).to be_falsey
      end

      it 'should not recognize non integers' do
        expect((Size === 10.0)).to be_falsey
        expect((Size === "12")).to be_falsey
      end

    end
  end
end
