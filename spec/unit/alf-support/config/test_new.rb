require 'spec_helper'
module Alf
  module Support
    describe Config, '.new' do

      let(:conf_subclass){
        Class.new(Config){
          option :ready, Boolean, false
        }
      }

      subject{ conf_subclass.new(h) }

      context 'when options must be coerced' do
        let(:h){ {ready: "true"} }

        it 'coerces them' do
          subject.ready?.should eq(true)
        end
      end

      context 'when an option is not known' do
        let(:h){ {nosuchone: "blah"} }

        it 'raises an error' do
          lambda{
            subject
          }.should raise_error(ConfigError, /No such option `nosuchone`/)
        end
      end

      context 'when an option cannot be coerced' do
        let(:h){ {ready: "blah"} }

        it 'raises an error' do
          lambda{
            subject
          }.should raise_error(ConfigError, /Invalid option value `ready`: `blah`/)
        end
      end

      context 'with a block passed' do
        subject{
          conf_subclass.new{|c| c.ready = true }
        }

        it 'yields the block' do
          subject.ready?.should be_truthy
        end
      end

      context 'when nothing is passed' do
        subject{ conf_subclass.new }

        it 'uses default values' do
          subject.ready?.should be_falsey
        end
      end

    end
  end
end
