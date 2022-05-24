require 'spec_helper'
module Alf
  describe Tuple, '.type' do

    let(:heading){ {name: String, status: Integer} }
    subject{ Tuple.type(heading) }

    it 'returns a subclass' do
      expect(subject).to be_kind_of(Class)
      expect(subject.superclass).to be(Alf::Tuple)
    end

    it 'coerces the heading' do
      expect(subject.heading).to be_kind_of(Heading)
    end

    it 'sets the heading correctly' do
      expect(subject.heading.to_hash).to eq(heading)
    end

    it 'is aliased as []' do
      expect(Tuple[heading]).to be_kind_of(Class)
      expect(Tuple[heading]).to eq(subject)
    end

  end
end
