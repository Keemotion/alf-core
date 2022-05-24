require 'update_helper'
module Alf
  module Update
    describe Inserter, 'matching' do

      let(:expr)     { matching(suppliers, parts) }
      let(:inserted) { [ {:sid => 1 } ] }
      let(:expected) { [ {:sid => 1 } ] }

      subject{ insert(expr, inserted) }

      it 'requests the insertion of the tuples on :suppliers' do
        subject
        expect(db_context.requests).to eq([ [:insert, :suppliers, expected ] ])
      end

    end
  end
end
