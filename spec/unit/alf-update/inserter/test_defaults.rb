require 'update_helper'
module Alf
  module Update
    describe Inserter, 'defaults' do

      let(:expr)     { defaults(suppliers, :foo => 12) }
      let(:inserted) { [ {:name => "Jones", :foo => 13}, {:name => "Smith"} ] }
      let(:expected) { [ {:name => "Jones", :foo => 13}, {:name => "Smith", :foo => 12} ] }

      subject{ insert(expr, inserted) }

      it 'requests the insertion of the tuples on :suppliers' do
        subject
        expect(db_context.requests).to eq([ [:insert, :suppliers, expected] ])
      end

    end
  end
end
