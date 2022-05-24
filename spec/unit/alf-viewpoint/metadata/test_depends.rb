require 'spec_helper'
module Alf
  module Viewpoint
    describe Metadata, "#depends" do

      context 'on empty dependencies' do
        let(:metadata){ Metadata.new }

        subject{ metadata.depends(a: [1, 2]) }

        it 'sets dependencies' do
          expect(subject.dependencies).to eq(a: [1, 2])
        end
      end

      context 'on disjoint dependencies' do
        let(:metadata){ Metadata.new([], a: [1, 2]) }

        subject{ metadata.depends(b: [3, 4]) }

        it 'sets dependencies' do
          expect(subject.dependencies).to eq(a: [1, 2], b: [3, 4])
        end
      end

      context 'on overlapping, non-conlictual dependencies' do
        let(:metadata){ Metadata.new([], a: [1, 2], b: [3, 4]) }

        subject{ metadata.depends(a: [1, 2], c: [5, 6]) }

        it 'sets dependencies' do
          expect(subject.dependencies).to eq(a: [1, 2], b: [3, 4], c: [5, 6])
        end
      end

      context 'on overlapping, conlictual dependencies' do
        let(:metadata){ Metadata.new([], a: [1, 2]) }

        subject{ metadata.depends(a: [1, 3]) }

        it 'raises an error' do
          expect(lambda{
            subject
          }).to raise_error("Composition conflict on `a`: [1, 2] vs. [1, 3]")
        end
      end

    end
  end
end
