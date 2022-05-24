require 'spec_helper'
module Alf
  module Support
    describe TupleScope, "[]" do

      context 'with a simple TupleScope' do
        let(:scope){ TupleScope.new(:a => 1, :b => 2) }

        it "delegates to the tuple" do
          expect(scope[:a]).to eq(1)
        end

        it "return nil on unexisting" do
          expect(scope[:c]).to be_nil
        end
      end

    end
  end
end
