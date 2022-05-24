require 'spec_helper'
module Alf
  describe AttrList, 'subset?' do

    context 'when equal' do
      let(:left){ AttrList[:id, :name] }
      let(:right){ AttrList[:name, :id] }

      it 'returns true if non proper' do
        expect(left.subset?(right)).to be_truthy
      end
      it 'returns false if proper' do
        expect(left.subset?(right, true)).to be_falsey
      end
    end

    context 'when both empty' do
      let(:left){ AttrList[] }
      let(:right){ AttrList[] }

      it 'returns true if non proper' do
        expect(left.subset?(right)).to be_truthy
      end
      it 'returns false if proper' do
        expect(left.subset?(right, true)).to be_falsey
      end
    end

    context 'when disjoint' do
      let(:left){ AttrList[:status] }
      let(:right){ AttrList[:name, :id] }

      it 'returns false' do
        expect(left.subset?(right)).to be_falsey
        expect(left.subset?(right, true)).to be_falsey
      end
    end

    context 'when a proper subset' do
      let(:left){ AttrList[:name] }
      let(:right){ AttrList[:id, :name] }

      it 'returns true' do
        expect(left.subset?(right)).to be_truthy
        expect(left.subset?(right, true)).to be_truthy
      end
    end

  end
end
