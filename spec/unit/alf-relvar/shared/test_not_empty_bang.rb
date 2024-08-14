require 'spec_helper'
module Alf
  describe Relvar, 'not_empty!' do
    include Relvar

    subject{ not_empty! }

    context 'on an empty relvar' do
      let(:to_cog){ [] }

      it "should raise a fact error" do
        expect{ subject }.to raise_error(Alf::FactAssertionError)
      end
    end

    context 'on an non empty relvar' do
      let(:to_cog){ [ 1 ] }

      it{ should be(self) }
    end

    context 'on an empty relvar with an error message' do
      let(:to_cog){ [] }

      it "should raise a fact error" do
        expect{ not_empty!("foo") }.to raise_error(Alf::FactAssertionError, /foo/)
      end
    end

  end
end
