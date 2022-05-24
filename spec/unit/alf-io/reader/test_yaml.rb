require 'spec_helper'
require 'json'
module Alf
  describe Reader::YAML do
    it_should_behave_like "a Reader class"

    let(:str)   { input.to_yaml        }
    let(:io)    { StringIO.new(str)    }
    let(:reader){ Reader::YAML.new(io) }

    subject{ reader.to_a }

    describe "when called on a Array" do
      let(:input){ [{:id => 1},{:id => 2}] }

      it "read the lines as expected" do
        expect(subject).to eq(input)
      end
    end

    describe "when called on a Hash" do
      let(:input){ {:id => 1} }

      it "should yield the single Hash" do
        expect(subject).to eq([input])
      end
    end

  end
end
