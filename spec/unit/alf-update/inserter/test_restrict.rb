require 'update_helper'
module Alf
  module Update
    describe Inserter, 'restrict' do

      let(:expr)     { restrict(suppliers, :name => "Jones") }
      let(:inserted) { [ { :name => "Jones", :city => "London" } ] }
      let(:expected) { [ { :name => "Jones", :city => "London" } ] }

      subject{ insert(expr, inserted) }

      it 'requests the insertion of the tuples on :suppliers' do
        subject
        expect(db_context.requests).to eq([ [:insert, :suppliers, expected ] ])
      end

    end
  end
end
