require 'spec_helper'
describe Alf::Relation, 'to_array' do

  let(:rel) {
    examples_database.query do
      group((project suppliers, [:city, :name]), [:name], :incity)
    end
  }

  let(:expected){
    [
      {:city => 'Athens', :incity => [ {:name => 'Adams'} ]},
      {:city => 'London', :incity => [ {:name => 'Clark'}, {:name => 'Smith'} ]},
      {:city => 'Paris',  :incity => [ {:name => 'Blake'}, {:name => 'Jones'} ]},
    ]
  }

  let(:ordering){ [:city, [:incity, :name]] }

  it 'recursively converts to sorted arrays' do
    expect(rel.to_array(:sort => ordering)).to eq(expected)
  end

  it 'is aliased as to_a' do
    expect(rel.to_a(:sort => ordering)).to eq(expected)
  end

end
