require 'spec_helper'
module Alf
  module Support
    describe Config, "merge" do

      let(:config_class){
        Class.new(Config){
          option :ready, Boolean, true
          option :hello, String, "world"
        }
      }
      let(:config){ config_class.new }

      subject{ config.merge(ready: false) }

      it{ should be_a(config_class) }

      it 'is not the original' do
        expect(subject).to_not be(config)
      end

      it 'merges the new options' do
        expect(subject.ready?).to eq(false)
        expect(subject.hello).to eq("world")
      end

      it 'does not touch the original' do
        expect(config.ready?).to eq(true)
        expect(config.hello).to eq("world")
      end

    end
  end
end
