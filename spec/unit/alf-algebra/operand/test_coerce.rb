require 'spec_helper'
module Alf
  module Algebra
    describe Operand, '.coerce' do

      subject{ Operand.coerce(arg) }

      context "on a Symbol" do
        let(:arg){ :suppliers }

        it 'coerces it as a named operand' do
          expect(subject).to be_kind_of(Operand::Named)
          expect(subject.name).to eq(:suppliers)
        end
      end

      context "on a Hash" do
        let(:arg){ {name: "Jones"} }

        it 'coerces it as a proxy operand on an array' do
          expect(subject).to be_kind_of(Operand::Proxy)
          expect(subject.subject).to eq([ arg ])
        end
      end

      context "on a Tuple" do
        let(:arg){ Tuple(name: "Jones") }

        it 'coerces it as a proxy operand on an array' do
          expect(subject).to be_kind_of(Operand::Proxy)
          expect(subject.subject).to eq([ arg ])
        end
      end

    end
  end
end
