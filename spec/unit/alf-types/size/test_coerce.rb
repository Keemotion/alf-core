require 'spec_helper'
module Alf
  module Types
    describe Size, "coerce" do

      it 'should coerce strings correctly' do
        expect(Size.coerce("0")).to eq(0)
        expect(Size.coerce("10")).to eq(10)
      end

      it 'should raise TypeError on negative integers' do
        expect{ Size.coerce("-1") }.to raise_error(TypeError)
      end

      it 'should raise on non integers' do
        expect{
          Size.coerce("hello")
        }.to raise_error(TypeError)
      end

    end
  end
end
