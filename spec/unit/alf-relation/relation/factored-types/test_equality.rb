require 'spec_helper'
module Alf
  describe Relation, '==' do

    let(:type){ Relation[name: String, status: Integer] }

    subject{ type == other }

    context 'with itself' do
      let(:other){ type }

      it{ should be_truthy }
    end

    context 'with another equivalent' do
      let(:other){ Relation[name: String, status: Integer] }

      it{ should be_truthy }
    end

    context 'with another, non equivalent' do
      let(:other){ Relation[name: String] }

      it{ should be_falsey }
    end

  end
end
