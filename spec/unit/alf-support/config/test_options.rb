require 'spec_helper'
module Alf
  module Support
    describe Config, '.options' do

      let(:conf){
        Class.new(Config){
          option :ready, Boolean, false
          option :hello, String, "world"
        }
      }

      it 'should contain the options' do
        expect(conf.options).to eq([
          [:ready, Boolean, false],
          [:hello, String, "world"]
        ])
      end

    end
  end
end
