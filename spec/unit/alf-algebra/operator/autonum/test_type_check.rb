require 'type_check_helper'
module Alf
  module Algebra
    describe Autonum, 'type_check' do

      subject{ op.type_check }

      context 'when ok' do
        let(:op){
          autonum(suppliers, :auto)
        }

        it{ should eq(op.heading) }
      end

      context 'when name clash' do
        let(:op){
          autonum(suppliers, :name)
        }

        it 'should raise an error' do
          expect(lambda{
            subject
          }).to raise_error(TypeCheckError, /cannot override `name`/)
        end
      end

    end
  end
end
