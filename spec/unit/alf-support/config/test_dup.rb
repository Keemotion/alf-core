require 'spec_helper'
module Alf
  module Support
    describe Config, 'dup' do

      let(:conf_subclass){
        Class.new(Config){
          option :ready, Boolean, false
          option :preferences, Array, []
          option :aproc, Boolean, ->{ !ready? }
        }
      }

      let(:config){ conf_subclass.new }

      context 'when not freezed' do
        subject{ config.dup }

        it 'should return a different instance' do
          expect(subject).to be_kind_of(conf_subclass)
          expect(subject).to_not be(config)
        end

        it 'should dup all options while keeping them equal' do
          conf_subclass.options.each do |name,_,_|
            mine, yours = subject[name], config[name]
            expect(mine).to eq(yours)
            expect(mine).to_not be(yours) unless Boolean===mine
          end
        end

        it 'should keep the semantics of Proc options' do
          expect(subject.aproc?).to be_truthy
          subject.ready = true
          expect(subject.aproc?).to be_falsey
        end
      end

      context 'when frozen' do
        subject{ config.freeze.dup }

        it 'should return a non-frezed instance' do
          expect(subject).to be_kind_of(conf_subclass)
          expect(subject).to_not be_frozen
        end

        it 'allow modifying options on the new instance' do
          expect{
            subject.ready = true
          }.to_not raise_error
          expect(subject.ready?).to be_truthy
          expect(config.ready?).to be_falsey
        end
      end

    end
  end
end
