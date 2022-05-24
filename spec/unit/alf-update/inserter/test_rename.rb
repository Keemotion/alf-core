require 'update_helper'
module Alf
  module Update
    describe Inserter, 'rename' do

      let(:expr)     { rename(suppliers, :name => :nome) }
      let(:inserted) { [ {:nome => "Jones"}, {:nome => "Smith"} ] }
      let(:expected) { [ {:name => "Jones"}, {:name => "Smith"} ] }

      subject{ insert(expr, inserted) }

      it 'requests the insertion of the tuples on :suppliers' do
        subject
        expect(db_context.requests).to eq([ [:insert, :suppliers, expected] ])
      end

    end
  end
end
