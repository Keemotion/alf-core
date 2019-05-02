require 'update_helper'
module Alf
  module Update
    describe Deleter, 'wrap' do

      let(:expr){ wrap(suppliers, [:city], :foo) }

      subject{ delete(expr, predicate) }

      context 'pass-through' do
        let(:predicate){ Predicate.eq(:id => 1) }

        it 'requests the deletion on :suppliers' do
          subject
          db_context.requests.should eq([ [:delete, :suppliers, predicate] ])
        end
      end

      context 'non pass-through' do
        let(:predicate){ Predicate.eq(:foo => 1) }

        it 'requests the deletion on :suppliers' do
          skip "need for Predicate.in" do
            subject
          end
        end
      end

    end
  end
end
