require 'update_helper'
module Alf
  module Update
    describe Inserter, 'compact' do

      let(:expr)     { compact(suppliers) }
      let(:inserted) { [ {:name => "Jones"} ] }
      let(:expected) { [ {:name => "Jones"} ] }

      subject{ insert(expr, inserted) }

      it 'requests the insertion of the tuples on :suppliers' do
        subject
        expect(db_context.requests).to eq([ [:insert, :suppliers, expected] ])
      end

    end
  end
end
