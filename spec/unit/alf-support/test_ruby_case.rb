require 'spec_helper'
module Alf
  describe Support, "ruby_case" do

    let(:tools){ Object.new.extend(Support) }

    it "should work on one word" do
      expect(tools.ruby_case(:Alf)).to eq("alf")
    end

    it "should work on multiple words" do
      expect(tools.ruby_case(:HelloWorld)).to eq("hello_world")
    end

  end
end
