require 'spec_helper'
module Alf
  describe Support, "class_name" do

    let(:tools){ Object.new.extend(Support) }

    it "should work on top-level namespaces" do
      expect(tools.class_name(Alf)).to eq(:Alf)
    end

    it "should work on non top-level namespaces" do
      expect(tools.class_name(Alf::Support)).to eq(:Support)
    end

  end
end
