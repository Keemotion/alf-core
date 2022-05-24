require 'update_helper'
module Alf
  module Update
    describe Inserter, 'join' do

      let(:expr)     { join(suppliers, parts) }
      let(:inserted) { [ {:sid => 1, :pid => 2} ] }

      subject{ insert(expr, inserted) }

      it 'requests the insertion of the tuples on :suppliers' do
        subject
        expect(db_context.requests).to eq([
          [:insert, :suppliers, [ {:sid => 1} ] ],
          [:insert, :parts,     [ {:pid => 2} ] ],
        ])
      end

    end
  end
end
