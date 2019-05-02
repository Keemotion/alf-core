require 'spec_helper'
module Alf
  class Adapter
    describe Connection, "lock" do
      let(:conn){ Connection.new(nil) }

      subject{ conn.lock(:name, :exclusive){ @seen = true } }

      it 'yields the block' do
        subject
        @seen.should be_truthy
      end

    end
  end
end
