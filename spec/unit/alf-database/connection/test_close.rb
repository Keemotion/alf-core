require 'spec_helper'
module Alf
  class Database
    describe Connection, "close" do

      let(:connection_handler){ ->(opts){ self } }

      let(:conn){ Connection.new(self, &connection_handler) }

      subject{ conn.close }

      def close
        @seen = true
      end

      it 'should close the physical connection' do
        subject
        expect(@seen).to be_truthy
      end

      it 'should close the connection itself' do
        subject
        expect(conn).to be_closed
      end

    end
  end
end
