require 'spec_helper'
module Alf
  describe Relation, '.coerce' do

    subject{ type.coerce(tuples) }

    context 'on single attributes' do
      let(:type)    { Relation[name: String,  status: Integer]  }
      let(:expected){ Relation(name: "Smith", status: 20)      }
      let(:tuples){
        [ {'name' => "Smith", 'status' => "20"} ]
      }


      it 'coerces attributes' do
        expect(subject).to eq(expected)
      end
    end

    context 'with a relation-valued attribute' do
      let(:type)    { Relation[name: String,  prices: Relation[price: Float]]  }
      let(:expected){ Relation(name: "Smith", prices: Relation(price: [12.0, 14.0])) }
      let(:tuples){
        [{'name' => "Smith", 'prices' => [{'price' => "12.0"}, {'price' => "14.0"}]}]
      }

      it 'coerces the RVA as well' do
        expect(subject).to eq(expected)
      end
    end

    context 'with a subclass of tuple' do
      let(:tuple_type){ Class.new(Tuple[price: Integer]) }
      let(:type){ Relation[tuple_type] }
      let(:tuples){
        [{'price' => '12'}]
      }

      it 'coerces the tuples as correct instances' do
        expect(subject.all?{|t|
          puts t.class unless t.is_a?(tuple_type)
          expect((tuple_type === t)).to be_truthy
          expect(t).to be_kind_of(tuple_type)
        }).to be_truthy
      end
    end

  end
end
