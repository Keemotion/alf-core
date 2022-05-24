require 'spec_helper'
module Alf
  describe Relation, '<=>' do

    let(:type) { Relation[name: String, status: Integer] }
    let(:supertype) { Relation[name: String, status: Numeric] }

    subject{ type <=> other }

    context 'on something else' do
      let(:other){ Integer }

      it{ should be_nil }
    end

    context 'on itself' do
      let(:other){ type }

      it{ should eq(0) }
    end

    context 'on same type' do
      let(:other){ Relation[name: String, status: Integer] }

      it{ should eq(0) }
    end

    context 'on a super type' do
      let(:other){ supertype }

      it{ should eq(-1) }
    end

    context 'the shortcuts' do

      it 'the > shortcut classifies correctly' do
        expect((supertype > supertype)).to be_falsey
        expect((supertype > type)).to be_truthy
      end

      it 'the >= shortcut classifies correctly' do
        expect((supertype >= supertype)).to be_truthy
        expect((supertype >= type)).to be_truthy
      end

      it 'the < shortcut classifies correctly' do
        expect(supertype < supertype).to be_falsey
        expect(supertype < type).to be_falsey
      end

      it 'the <= shortcut classifies correctly' do
        expect(supertype <= supertype).to be_truthy
        expect(supertype <= type).to be_falsey
      end
    end

  end
end
