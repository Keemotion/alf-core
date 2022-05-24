require 'update_helper'
module Alf
  module Update
    describe Inserter, 'identifier' do

      let(:expr)     { suppliers          }
      let(:inserted) { [ {:id => 1} ]     }

      subject{ insert(expr, inserted) }

      it 'requests the insertion of the tuples on :suppliers' do
        subject
        expect(db_context.requests).to eq([ [:insert, :suppliers, inserted] ])
      end

    end
  end
end
