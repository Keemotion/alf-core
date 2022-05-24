require 'type_check_helper'
module Alf
  module Algebra
    describe Join, 'type_check' do

      subject{ op.type_check }

      context 'when ok' do
        let(:op){
          join(suppliers, suppliers)
        }

        it{ should eq(op.heading) }
      end

      context 'when nothing in common' do
        let(:right){
          an_operand.with_heading(foo: Integer)
        }
        let(:left){
          an_operand.with_heading(bar: String)
        }
        let(:op){
          join(left, right)
        }

        it{ should eq(op.heading) }
      end

      context 'when heading mismatch' do
        let(:right){
          an_operand.with_heading(sid: Integer)
        }
        let(:left){
          an_operand.with_heading(sid: String)
        }
        let(:op){
          join(left, right)
        }

        context 'when strict' do
          subject{ op.type_check(strict: true) }

          it 'should raise an error' do
            expect(lambda{
              subject
            }).to raise_error(TypeCheckError, /heading mismatch/)
          end
        end

        context 'when not strict' do
          subject{ op.type_check }

          it 'should not raise an error' do
            expect(subject).to eq(op.heading)
          end
        end
      end

    end
  end
end
