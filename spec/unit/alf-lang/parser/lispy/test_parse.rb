require 'spec_helper'
module Alf
  module Lang
    module Parser
      describe Lispy do

        context 'when unbound' do
          let(:lispy){ Lispy.new }

          it 'allows parsing predicate expressions' do
            p = lispy.parse{ eq(:x, 1) & neq(:y, 2) }
            expect(p).to be_kind_of(Alf::Predicate)
          end

          it 'allows parsing relational expressions' do
            p = lispy.parse{ project(:suppliers, [:sid]) }
            expect(p).to be_kind_of(Algebra::Project)
          end
        end

        context 'when bound' do
          let(:lispy){ Lispy.new([], 12) }

          it 'allows parsing predicate expressions' do
            p = lispy.parse{ eq(:x, 1) & neq(:y, 2) }
            expect(p).to be_kind_of(Alf::Predicate)
          end

          it 'deeply binds parsed relational expressions' do
            p = lispy.parse{ project(:suppliers, [:sid]) }
            expect(p).to be_kind_of(Algebra::Project)
          end
        end

      end
    end
  end
end
