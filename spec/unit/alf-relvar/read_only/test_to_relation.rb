require 'spec_helper'
module Alf
  module Relvar
    describe ReadOnly, "to_relation" do

      let(:value){ Relation(id: 1)     }
      let(:rv)   { ReadOnly.new(value) }

      subject{ rv.to_relation }

      it 'is as expected' do
        expect(subject).to be(value)
      end

    end
  end
end
