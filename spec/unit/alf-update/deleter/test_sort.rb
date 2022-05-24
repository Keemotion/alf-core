require 'update_helper'
module Alf
  module Update
    describe Deleter, 'sort' do

      let(:expr)     { sort(suppliers, [[:name, :asc]]) }
      let(:predicate){ Predicate.eq(:name => "Jones") }

      subject{ delete(expr, predicate) }

      it 'requests the deletion on :suppliers' do
        subject
        expect(db_context.requests).to eq([ [:delete, :suppliers, predicate] ])
      end

    end
  end
end
