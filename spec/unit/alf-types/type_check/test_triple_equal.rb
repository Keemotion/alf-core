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
          (type_check === tuple).should be_truthy
          (type_check === missing).should be_falsey
          (type_check === extra).should be_falsey
          (type_check === mix).should be_falsey
          (type_check === invalid).should be_falsey
        end
      end

      context 'when not strict' do
        let(:type_check){ TypeCheck.new(heading, false) }

        it 'accepts the valid tuple and its projections' do
          (type_check === tuple).should be_truthy
          (type_check === missing).should be_truthy
          (type_check === extra).should be_falsey
          (type_check === mix).should be_falsey
          (type_check === invalid).should be_falsey
        end
      end

      context 'when passed invalid tuples' do
        let(:type_check){ TypeCheck.new(heading) }

        it 'rejects them simply' do
          (type_check === 12).should be_falsey
          (type_check === nil).should be_falsey
          (type_check === self).should be_falsey
          (type_check === {'name' => 'Smith', 'status' => 20}).should be_falsey
        end
      end

      context 'when passed a real Tuple' do
        let(:type_check){ TypeCheck.new(heading) }

        it 'accepts it if valid' do
          (type_check === Tuple(tuple)).should be_truthy
        end
      end
    end
  end
end
