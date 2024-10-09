require 'spec_helper'
module Alf
  class Adapter
    describe Connection, "migrate!" do
      let(:conn){ Connection.new(nil) }

      subject{ conn.migrate!(hello: "world") }

      it 'raises an NotSupportedError by default' do
        expect{
          subject
        }.to raise_error(NotSupportedError)
      end

    end
  end
end
