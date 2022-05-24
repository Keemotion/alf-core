require 'update_helper'
module Alf
  module Update
    describe Deleter, 'group' do

      let(:expr){ group(suppliers, [:city], :foo) }

      subject{ delete(expr, predicate) }

      context 'pass-through' do
        let(:predicate){ Predicate.eq(:id => 1) }

        it 'requests the deletion on :suppliers' do
          subject
          expect(db_context.requests).to eq([ [:delete, :suppliers, predicate] ])
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
