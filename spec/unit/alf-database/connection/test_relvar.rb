require 'spec_helper'
module Alf
  class Database
    describe Connection, "relvar" do

      let(:conn){ sap_conn }

      context 'with a leaf operand' do
        subject{ conn.relvar{ suppliers } }

        it{ should be_a(Relvar::Base) }

        it 'has the expected name' do
          expect(subject.expr.name).to eq(:suppliers)
        end

        it 'is bound to the serving connection' do
          expect(subject.connection!).to be(conn)
        end
      end

      context 'with a complex expression' do
        subject{ conn.relvar{ project(suppliers, [:sid]) } }

        it{ should be_a(Relvar::Virtual) }

        it 'has the expected expression' do
          expect(subject.expr).to be_kind_of(Algebra::Project)
        end
      end

    end
  end
end
