require 'spec_helper'
module Alf
  module Algebra
    describe Page do

      let(:operator_class){ Page }

      it_should_behave_like("An operator class")

      subject{
        a_lispy.page(an_operand, [[:name, :asc]], 2)
      }

      it { should be_a(Page) }

      it 'should have correct ordering' do
        expect(subject.ordering).to eq(Ordering.coerce([[:name, :asc]]))
      end

      it 'should have correct page index' do
        expect(subject.page_index).to eq(2)
      end

      it 'should have default page size' do
        expect(subject.page_size).to eq(25)
      end

    end
  end
end
