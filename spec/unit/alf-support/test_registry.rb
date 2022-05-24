require 'spec_helper'
module Alf
  module Support
    describe Registry do

      let(:clazz){ Class.new.extend(Registry) }
      let(:seen) { [] }

      before do
        clazz.listen{|n,c| seen << [n,c] }
      end

      describe 'when used with classes' do
        before do
          clazz.register(Integer, clazz)
        end

        it 'installs class-level methods' do
          expect(clazz).to respond_to(:integer)
        end

        it 'add the class to the registered elements' do
          expect(clazz.registered).to eq([Integer])
          expect(clazz.all).to eq([Integer])
        end

        it 'calls the listeners' do
          expect(seen).to eq([[:integer, Integer]])
        end
      end

      describe 'when used with an array and arguments' do
        before do
          clazz.register([:hello, Integer], clazz)
        end

        it 'installs class-level methods' do
          expect(clazz).to respond_to(:hello)
        end

        it 'maintain the registered elements' do
          expect(clazz.registered).to eq([[:hello, Integer]])
        end

        it 'calls the listeners' do
          expect(seen).to eq([[:hello, Integer]])
        end
      end

      describe 'when listen after some components have already been registered' do
        before do
          clazz.register(Integer, clazz)
        end
        it 'calls the listener with registered components at listening time' do
          seen = []
          clazz.listen{|n,c| seen << [n,c] }
          expect(seen).to eq([[:integer, Integer]])
        end
      end

    end
  end
end
