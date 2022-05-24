require 'spec_helper'
module Alf
  module Algebra
    module Operand
      describe Named, "to_relvar" do

        let(:operand){ Named.new(:foo, self) }

        subject{ operand.to_relvar }

        it 'returns a base relvar' do
          expect(subject).to be_kind_of(Relvar::Base)
        end

      end
    end
  end
end
