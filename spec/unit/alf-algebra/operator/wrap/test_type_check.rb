require 'type_check_helper'
module Alf
  module Algebra
    describe Wrap, 'type_check' do

      subject{ op.type_check }

      context 'when ok' do
        let(:op){
          wrap(suppliers, [:status, :city], :extra)
        }

        it{ should eq(op.heading) }
      end

      context 'when ok (allowed overriding)' do
        let(:op){
          wrap(suppliers, [:status, :city], :status)
        }

        it{ should eq(op.heading) }
      end

      context 'when no such attributes' do
        let(:op){
          wrap(suppliers, [:status, :foo, :bar], :extra)
        }

        it 'should raise an error' do
          expect{
            subject
          }.to raise_error(TypeCheckError, /no such attributes `foo`,`bar`/)
        end
      end

      context 'when diasllowed overriding' do
        let(:op){
          wrap(suppliers, [:status, :city], :name)
        }

        it 'should raise an error' do
          expect{
            subject
          }.to raise_error(TypeCheckError, /cannot override `name`/)
        end
      end

    end
  end
end
