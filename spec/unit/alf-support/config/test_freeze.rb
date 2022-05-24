require 'spec_helper'
module Alf
  module Support
    describe Config, 'freeze' do

      let(:conf_subclass){
        Class.new(Config){
          option :ready, Boolean, false
          option :preferences, Array, []
        }
      }

      let(:config){ conf_subclass.new }

      subject{ config.freeze }

      it 'should return the instance' do
        expect(subject).to be(config)
      end

      it 'should freeze the scalar options' do
        subject
        expect(lambda{
          config.ready = true
        }).to raise_error(/can't modify frozen/)
      end

      it 'should freeze the non-scalar options' do
        subject
        expect(lambda{
          config.preferences << "foo"
        }).to raise_error(/can't modify frozen/)
      end

    end
  end
end
