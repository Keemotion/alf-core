require 'spec_helper'
module Alf
  module Algebra
    describe Generator do

      let(:operator_class){ Generator }

      it_should_behave_like("An operator class")

      context "when providing a size and a name" do
        subject{ a_lispy.generator(2, :id) }

        it{ should be_a(Generator) }

        it 'has specified size and name' do
          expect(subject.size).to eq(2)
          expect(subject.as).to eq(:id)
        end
      end # size and name

    end
  end
end
