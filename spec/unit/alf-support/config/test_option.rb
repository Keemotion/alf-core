require 'spec_helper'
module Alf
  module Support
    describe Config, '.option' do

      let(:conf1){
        Class.new(Config){
          option :ready, Boolean, false
          option :which, String, ->{ "foo" }
          option :done,  Proc, ->{ "bar" }
          option :cross, String, ->{ which.capitalize }
        }
      }

      let(:conf2){
        Class.new(Config){
          option :hello, String, "world"
        }
      }

      it 'does not mix subclasses' do
        expect(conf1.new).to respond_to(:ready?)
        expect(conf2.new).to_not respond_to(:ready?)
        expect(conf1.new).to_not respond_to(:hello)
        expect(conf2.new).to respond_to(:hello)
      end

      it 'supports procs' do
        expect(conf1.new.which).to eq("foo")
      end

      it 'executes proc in that context' do
        expect(conf1.new.cross).to eq("Foo")
      end

      it 'does not confuse procs' do
        expect(conf1.new.done).to be_kind_of(Proc)
      end

    end
  end
end
