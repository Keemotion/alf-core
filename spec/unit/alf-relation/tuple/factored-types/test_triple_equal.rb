require 'spec_helper'
module Alf
  describe Tuple, '===' do

    let(:type){ Tuple[heading] }

    subject{ type === value }

    context 'when the exact types' do
      let(:heading){ Heading.new(name: String, status: Integer) }

      context 'on a valid value built with itself' do
        let(:value){ type.coerce(name: "Smith", status: 20) }

        it{ should be_truthy }
      end

      context 'on a valid value but built with Tuple' do
        let(:value){ Tuple.coerce(name: "Smith", status: 20) }

        it{ should be_truthy }
      end
    end

    context 'with a super type' do
      let(:heading){ Heading.new(name: String, status: Integer) }

      context 'on a valid value built with itself' do
        let(:value){ type.coerce(name: "Smith", status: 20) }

        it{ should be_truthy }
      end

      context 'on a valid value but built with Tuple' do
        let(:value){ Tuple.coerce(name: "Smith", status: 20) }

        it{ should be_truthy }
      end
    end

    context 'with a DUM RVA' do
      let(:heading){ {sid: String, supplies: Relation[{}]} }
      let(:value){ Tuple.coerce(sid: "S5", supplies: Alf::Relation([])) }

      it{ should be_truthy }
    end

    context 'with a DUM RVA and a master Relation type' do
      let(:heading){ {sid: String, supplies: Relation} }
      let(:value){ Tuple.coerce(sid: "S5", supplies: Alf::Relation([])) }

      it{ should be_truthy }
    end

  end
end
