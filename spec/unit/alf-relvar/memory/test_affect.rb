require 'spec_helper'
module Alf
  module Relvar
    describe Memory, "affect" do

      let(:before){ Relation(id: 1) }
      let(:after) { Relation(id: 2) }
      let(:rv)    { Memory.new(before) }

      subject{
        rv.affect(after)
      }

      it 'is as expected' do
        subject
        expect(rv.value).to eq(after)
      end

    end
  end
end
