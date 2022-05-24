require 'spec_helper'
describe Alf, '.database' do

  subject{ Alf.database(Path.dir, schema_cache: false){|d| @seen = d} }

  it{ should be_a(Alf::Database) }

  it 'coerces the adapter' do
    expect(subject.adapter).to be_kind_of(Alf::Adapter::Folder)
  end

  it 'sets the options' do
    expect(subject.schema_cache?).to eq(false)
  end

  it 'yields the options to the block' do
    subject
    expect(@seen).to be_kind_of(Alf::Database::Options)
  end

end
