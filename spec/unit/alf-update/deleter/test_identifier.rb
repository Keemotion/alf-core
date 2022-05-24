require 'update_helper'
module Alf
  module Update
    describe Deleter, 'identifier' do

      let(:expr)     { suppliers            }
      let(:inserted) { [ {:id => 1} ]       }
      let(:predicate){ Predicate.eq(:id, 1) }

      subject{ delete(expr, predicate) }

      it 'requests the deletion of the tuples on :suppliers' do
        subject
        expect(db_context.requests).to eq([ [:delete, :suppliers, predicate] ])
      end

    end
  end
end
