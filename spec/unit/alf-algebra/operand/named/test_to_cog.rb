require 'spec_helper'
module Alf
  module Algebra
    module Operand
      describe Named, "to_cog" do

        let(:operand){ Named.new(:foo, self) }

        subject{ operand.to_cog(12) }

        def cog(plan, expr)
          expect(plan).to eq(12)
          expect(expr).to be(operand)
          [:a_cog, expr.name]
        end

        it 'delegates to the underlying connection when bound' do
          expect(subject).to eq([:a_cog, :foo])
        end

      end
    end
  end
end
