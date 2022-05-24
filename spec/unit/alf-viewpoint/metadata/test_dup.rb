require 'spec_helper'
module Alf
  module Viewpoint
    describe Metadata, "#dup" do

      let(:metadata){ Metadata.new([1, 2], {a: [3, 4]}, [:m]) }

      subject{ metadata.dup }

      it 'should be a different Metadata' do
        expect(subject).to be_kind_of(Metadata)
        expect(subject).to_not be(metadata)
      end

      it 'should have different yet equal expectations' do
        expect(subject.expectations).to_not be(metadata.expectations)
        expect(subject.expectations).to eq(metadata.expectations)
      end

      it 'should have different yet equal dependencies' do
        expect(subject.dependencies).to_not be(metadata.dependencies)
        expect(subject.dependencies).to eq(metadata.dependencies)
      end

      it 'should have different yet equal members' do
        expect(subject.members).to_not be(metadata.members)
        expect(subject.members).to eq(metadata.members)
      end

    end
  end
end
