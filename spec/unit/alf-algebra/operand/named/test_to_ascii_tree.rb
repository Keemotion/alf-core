require 'spec_helper'
module Alf
  module Algebra
    module Operand
      describe Named, "to_ascii_tree" do

        subject{ operand.to_ascii_tree }

        let(:operand){ Named.new(:foo, self) }

        it 'returns the heading' do
          expect(subject).to eq("foo\n")
        end

      end
    end
  end
end
