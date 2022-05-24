require 'spec_helper'
module Alf
  describe Relation, 'to_ruby_literal' do

    let(:type){ Relation[name: String, status: Integer] }

    subject{ type.to_ruby_literal }

    it 'should be human friendly' do
      expect(subject).to eq("Alf::Relation[{:name => String, :status => Integer}]")
    end

    it 'should allow eval roundtrip' do
      expect(::Kernel.eval(subject)).to eq(type)
    end

  end
end
