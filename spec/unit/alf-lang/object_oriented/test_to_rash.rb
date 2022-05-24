require 'spec_helper'
module Alf
  module Lang
    describe ObjectOriented, 'to_rash' do

      include ObjectOriented.new(supplier_names_relation)

      subject{
        to_rash(options).each_line.map do |line|
          ::Kernel.eval(line)
        end
      }

      before do
        expect(subject).to be_kind_of(Array)
        subject.each{|t| expect(t).to be_a(Hash)}
      end

      after do
        expect(Relation(subject)).to eq(_self_operand)
      end

      context 'when an ordering is specified' do
        let(:ordering){ [[:name, :desc]] }
        let(:options){ {:sort => ordering} }
        it 'respects it' do
          expected = supplier_names.sort.reverse
          expect(subject.map{|t| t[:name]}).to eq(expected)
        end
      end

    end
  end
end
