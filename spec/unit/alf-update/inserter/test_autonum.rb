require 'update_helper'
module Alf
  module Update
    describe Inserter, 'autonum' do

      let(:expr)     { autonum(suppliers, :auto)          }
      let(:inserted) { [ {:auto => 1, :name => "Jones"} ] }
      let(:expected) { [ {:name => "Jones"} ]             }

      subject{ insert(expr, inserted) }

      it 'requests the insertion of the tuples on :suppliers' do
        subject
        expect(db_context.requests).to eq([ [:insert, :suppliers, expected] ])
      end

    end
  end
end
