require 'spec_helper'
module Alf
  describe Reader::Rash do
    it_should_behave_like "a Reader class"

    let(:lines){ [{:id => 1},{:id => 2}]                 }
    let(:str)  { lines.collect{|s| s.inspect}.join("\n") }
    let(:io)   { StringIO.new(str) }

    describe "when called on a StringIO" do

      let(:reader){ Reader::Rash.new(io) }

      it "should be enumerable" do
        expect(reader.to_a).to eq(lines)
      end

    end

    describe "when called on a String" do

      let(:file){ File.expand_path('../input.rash', __FILE__) }
      let(:reader){ Reader::Rash.new(file) }

      it "should be enumerable" do
        expect(reader.to_a).to eq(lines)
      end

    end

  end
end
