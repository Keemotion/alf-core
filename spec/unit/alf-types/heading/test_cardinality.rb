require 'spec_helper'
module Alf
  describe Heading, "cardinality" do

    subject{ heading.cardinality }

    after do
      expect(subject).to eq(heading.count)
      expect(subject).to eq(heading.size)
    end

    context 'on an empty heading' do
      let(:heading){ Heading.new({}) }

      it{ should eq(0) }
    end

    context 'on a non-empty heading' do
      let(:heading){ Heading.new({:foo => :bar}) }

      it{ should eq(1) }
    end

  end
end
