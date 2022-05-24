require 'spec_helper'
module Alf
  describe Support, "rubycase_name" do

    let(:tools){ Object.new.extend(Support) }

    it "should work on a Symbol" do
      expect(tools.rubycase_name(:Alf)).to eq(:alf)
    end

    it "should work on a String" do
      expect(tools.rubycase_name("HelloWorld")).to eq(:hello_world)
    end

    it "should work on a Class" do
      expect(tools.rubycase_name(String )).to eq(:string)
    end

    it "should work on a Module" do
      expect(tools.rubycase_name(Algebra::NonRelational)).to eq(:non_relational)
    end

  end
end
