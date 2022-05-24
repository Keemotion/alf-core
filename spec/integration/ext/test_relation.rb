require 'spec_helper'
describe "Relation()" do

  it 'returns a Relation' do
    expect(Relation(:name => "Alf")).to be_kind_of(Alf::Relation)
  end

  it 'helps building a singleton' do
    expect(Relation(:name => "Alf").cardinality).to eq(1)
  end

  it 'helps building a list if values' do
    expect(Relation(:name => ["Alf", "Myrrha"]).cardinality).to eq(2)
  end

end
