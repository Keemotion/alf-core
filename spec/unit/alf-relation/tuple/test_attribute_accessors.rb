require 'spec_helper'
module Alf
  module Types
    describe Tuple, "attribute accessors" do

      context 'when no conflict' do
        let(:tuple){ Tuple(:id => 1, :name => "Alf") }

        it 'has expected accessors' do
          expect(tuple.id).to eq(1)
          expect(tuple.name).to eq("Alf")
        end

        it 'does not confuse accessors and methods' do
          expect{
            tuple.id("hello")
          }.to raise_error(NoMethodError)
        end
      end

      context 'when a conflict' do
        let(:tuple){ Tuple(:size => 23, :map => "Alf") }

        it 'gives priority to attributes' do
          expect(tuple.size).to eq(23)
          expect(tuple.map).to eq("Alf")
        end

        it 'does not confuse accessors and methods' do
          expect(tuple.map{|x| "a value" }).to eq(["a value", "a value"])
        end
      end

    end
  end
end
