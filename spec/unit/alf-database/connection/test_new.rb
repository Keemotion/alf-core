require 'spec_helper'
module Alf
  class Database
    describe Connection, "new" do

      let(:connection_handler){ ->(opts){ "a connection" } }

      subject{ Connection.new(self, &connection_handler) }

      it 'should open the physical connection right away' do
        expect(subject).to_not be_closed
        expect(subject.adapter_connection).to eq("a connection")
      end

    end
  end
end
