require 'update_helper'
module Alf
  module Update
    describe Deleter, 'clip' do

      let(:expr)     { clip(suppliers, [:name]) }
      let(:predicate){ Predicate.eq(:name => "Jones") }

      subject{ delete(expr, predicate) }

      it 'requests the deletion on :suppliers' do
        subject
        expect(db_context.requests).to eq([ [:delete, :suppliers, predicate] ])
      end

    end
  end
end
