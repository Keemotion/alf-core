require 'spec_helper'
module Alf
  module Types
    describe TypeCheck, '===' do

      let(:heading){ Heading.new(name: String, status: Integer) }

      let(:tuple)  { {name: 'Smith', status: 20} }
      let(:missing){ {               status: 20} }
      let(:extra)  { {name: 'Smith', status: 20, foo: "bar"} }
      let(:mix)    { {               status: 20, foo: "bar"} }
      let(:invalid){ {name: 'Smith', status: "20"} }

      context 'when strict' do
        let(:type_check){ TypeCheck.new(heading) }

        it 'accepts the valid tuple only' do
          expect((type_check === tuple)).to be_truthy
          expect((type_check === missing)).to be_falsey
          expect((type_check === extra)).to be_falsey
          expect((type_check === mix)).to be_falsey
          expect((type_check === invalid)).to be_falsey
        end
      end

      context 'when not strict' do
        let(:type_check){ TypeCheck.new(heading, false) }

        it 'accepts the valid tuple and its projections' do
          expect((type_check === tuple)).to be_truthy
          expect((type_check === missing)).to be_truthy
          expect((type_check === extra)).to be_falsey
          expect((type_check === mix)).to be_falsey
          expect((type_check === invalid)).to be_falsey
        end
      end

      context 'when passed invalid tuples' do
        let(:type_check){ TypeCheck.new(heading) }

        it 'rejects them simply' do
          expect((type_check === 12)).to be_falsey
          expect((type_check === nil)).to be_falsey
          expect((type_check === self)).to be_falsey
          expect(type_check === {'name' => 'Smith', 'status' => 20}).to be_falsey
        end
      end

      context 'when passed a real Tuple' do
        let(:type_check){ TypeCheck.new(heading) }

        it 'accepts it if valid' do
          expect((type_check === Tuple(tuple))).to be_truthy
        end
      end
    end
  end
end
