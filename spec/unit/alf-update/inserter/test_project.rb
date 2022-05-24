require 'update_helper'
module Alf
  module Update
    describe Inserter, 'project' do

      let(:expr)     { project(suppliers, [:name]) }
      let(:inserted) { [ {:name => "Jones"} ]   }
      let(:expected) { [ {:name => "Jones"} ]   }

      subject{ insert(expr, inserted) }

      it 'requests the insertion of the tuples on :suppliers' do
        skip "defaults" do
          subject
          expect(db_context.requests).to eq([ [:insert, :suppliers, expected] ])
        end
      end

    end
  end
end
