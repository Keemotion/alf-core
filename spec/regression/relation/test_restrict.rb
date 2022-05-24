require 'spec_helper'
module Alf
  describe Relation, ".restrict bugs" do

    let(:arg){
      Relation([
        { sid: "S1", supplies: Relation(pid: ["P1", "P2"]) },
        { sid: "S5", supplies: Relation([]) }
      ])
    }

    context 'on Relation' do
      subject{ arg.restrict(sid: 'S5') }

      it 'does not raise a TypeError' do
        expect(subject).to be_kind_of(Relation)
      end
    end

  end
end
