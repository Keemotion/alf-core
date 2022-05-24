require 'spec_helper'
module Alf
  describe Database, '.new' do

    let(:adapter){ Adapter.new(nil) }

    after do
      expect(subject.adapter).to be_kind_of(Adapter)
    end

    context 'on a single adapter' do
      subject{ Database.new(adapter) }

      it 'uses the specified adapter' do
        expect(subject.adapter).to be(adapter)
      end

      it 'uses default options' do
        expect(subject.schema_cache?).to be_truthy
      end
    end

    context 'on an adapter to be coerced' do
      subject{ Database.new(Path.dir) }

      it 'coerces the adapter' do
        expect(subject.adapter).to be_kind_of(Adapter::Folder)
      end

      it 'uses default options' do
        expect(subject.schema_cache?).to be_truthy
      end
    end

    context 'when passing options' do
      subject{ Database.new(adapter, schema_cache: false) }

      it 'set the options correctly' do
        expect(subject.schema_cache?).to be_falsey
      end
    end

    context 'when a block is given' do
      subject{ Database.new(adapter){|d| @seen = d } }

      it 'yields the block' do
        expect(subject).to be_kind_of(Database)
        expect(@seen).to be_kind_of(Database::Options)
      end
    end

  end
end
