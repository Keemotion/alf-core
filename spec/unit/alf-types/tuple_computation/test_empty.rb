require 'spec_helper'
module Alf
  describe TupleComputation, "empty?" do

    subject{ comp.empty? }

    context 'when not empty' do
      let(:comp){
        TupleComputation[big?: ->{}, who: ->{}]
      }

      it{ should be_falsey }
    end

    context 'when empty' do
      let(:comp){
        TupleComputation[{}]
      }

      it{ should be_truthy }
    end

  end
end
