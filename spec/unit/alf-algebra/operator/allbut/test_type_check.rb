require 'type_check_helper'
module Alf
  module Algebra
    describe Allbut, 'type_check' do

      subject{ op.type_check }

      context 'when ok' do
        let(:op){
          allbut(suppliers, [:sid, :name])
        }

        it{ should eq(op.heading) }
      end

      context 'when projecting unexisting attribute' do
        let(:op){
          allbut(suppliers, [:sid, :unknown])
        }

        it 'should raise an error' do
          expect{
            subject
          }.to raise_error(TypeCheckError, /no such attribute `unknown`/)
        end
      end

      context 'when projecting unexisting attributes' do
        let(:op){
          allbut(suppliers, [:sid, :foo, :bar])
        }

        it 'should raise an error' do
          expect{
            subject
          }.to raise_error(TypeCheckError, /no such attributes `foo`,`bar`/)
        end
      end

    end
  end
end
