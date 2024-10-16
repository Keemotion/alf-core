require 'spec_helper'
module Alf
  describe Relvar, "upsert" do
    include Relvar

    let(:tuples){ Relation.coerce(:id => 1) }

    def insert(*args)
      @method = :insert
      @seen = args
    end

    def update(*args)
      @method = :update
      @seen = args
    end

    subject{ upsert(tuples) }

    context 'when the relvar is not empty' do
      let(:empty?){ false }

      it 'delegates an update to the connection' do
        subject
        expect(@method).to eq(:update)
        expect(@seen).to eq([tuples])
      end
    end

    context 'when the relvar is empty' do
      let(:empty?){ true }

      it 'delegates an insert to the connection' do
        subject
        expect(@method).to eq(:insert)
        expect(@seen).to eq([tuples])
      end
    end

  end
end
