require 'type_check_helper'
module Alf
  module Algebra
    describe Union, 'type_check' do

      subject{ op.type_check }

      context 'when ok' do
        let(:op){
          union(suppliers, suppliers)
        }

        it{ should eq(op.heading) }
      end

      context 'when heading mismatch' do
        let(:op){
          union(suppliers, supplies)
        }

        it 'should raise an error' do
          expect(lambda{
            subject
          }).to raise_error(TypeCheckError, /heading mismatch/)
        end
      end

    end
  end
end
