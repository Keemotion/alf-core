require 'update_helper'
module Alf
  module Update
    describe Deleter, 'intersect' do

      let(:expr)     { intersect(suppliers, parts)     }
      let(:predicate){ Predicate.eq(:city => "London") }

      subject{ delete(expr, predicate) }

      it 'requests the deletion on both :suppliers and :parts' do
        subject
        expect(db_context.requests).to eq([
          [:delete, :suppliers, predicate],
          [:delete, :parts, predicate]
        ])
      end

    end
  end
end
