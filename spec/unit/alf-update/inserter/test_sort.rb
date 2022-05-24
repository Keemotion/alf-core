require 'update_helper'
module Alf
  module Update
    describe Inserter, 'sort' do

      let(:expr)     { sort(suppliers, [[:name, :desc]]) }
      let(:inserted) { [ {:name => "Jones"}, {:name => "Smith"} ] }
      let(:expected) { [ {:name => "Smith"}, {:name => "Jones"} ] }

      subject{ insert(expr, inserted) }

      it 'requests the insertion of the tuples on :suppliers' do
        subject
        expect(db_context.requests).to eq([ [:insert, :suppliers, expected] ])
      end

    end
  end
end
