require 'spec_helper'
module Alf
  class Database
    describe Options, "freeze" do

      let(:opts){ Options.new(schema_cache: true) }

      subject{ opts.freeze }

      it{ should be(opts) }

      it 'should prevent further modifications' do
        expect{
          subject.schema_cache = false
        }.to raise_error(/can't modify frozen/)
      end

    end
  end
end
