require 'spec_helper'
module Alf
  module Viewpoint
    describe Metadata, "#initialize" do

      context 'without args' do
        subject{ Metadata.new }

        it 'has empty expectations' do
          expect(subject.expectations).to eq([])
        end

        it 'has empty dependencies' do
          expect(subject.dependencies).to eq({})
        end

        it 'has empty members' do
          expect(subject.members).to eq([])
        end
      end

      context 'with args' do
        subject{ Metadata.new([1], {:a => 2}, [:m]) }

        it 'has expected expectations' do
          expect(subject.expectations).to eq([1])
        end

        it 'has expected dependencies' do
          expect(subject.dependencies).to eq({:a => 2})
        end

        it 'has expected members' do
          expect(subject.members).to eq([:m])
        end
      end

    end
  end
end
