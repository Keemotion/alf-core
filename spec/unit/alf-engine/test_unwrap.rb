require 'spec_helper'
module Alf
  module Engine
    describe Unwrap do

      let(:input) {[
        {:wrapped => {:a => "a", :b => "b"}, :c => "c"}
      ]}

      let(:expected) {[
        {:a => "a", :b => "b", :c => "c"},
      ]}

      it "should unwrap as expected" do
        expect(Unwrap.new(input, :wrapped).to_a).to eq(expected)
      end

    end
  end
end
