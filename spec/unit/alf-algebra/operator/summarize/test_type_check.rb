require 'type_check_helper'
module Alf
  module Algebra
    describe Summarize, 'type_check' do

      subject{ op.type_check }

      context 'when ok' do
        let(:op){
          summarize(supplies, [:sid], :sum => sum{ qty })
        }

        it{ should eq(op.heading) }
      end

      context 'when unknown by' do
        let(:op){
          summarize(supplies, [:foo], :sum => sum{ qty })
        }

        it 'should raise an error' do
          expect(lambda{
            subject
          }).to raise_error(TypeCheckError, /no such attribute `foo`/)
        end
      end

      context 'when name clash' do
        let(:op){
          summarize(supplies, [:sid], :qty => sum{ qty })
        }

        it 'should raise an error' do
          expect(lambda{
            subject
          }).to raise_error(TypeCheckError, /cannot override `qty`/)
        end
      end

    end
  end
end
