require 'spec_helper'
module Alf
  module Relvar
    describe ReadOnly, "type" do

      let(:value){ Relation(id: 1)     }
      let(:rv)   { ReadOnly.new(value) }

      subject{ rv.type }

      it 'is as expected' do
        subject.should eq(Relation[id: Integer])
      end

    end
  end
end
