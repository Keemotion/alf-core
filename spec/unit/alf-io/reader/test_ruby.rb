require 'spec_helper'
module Alf
  describe Reader::Ruby do
    it_should_behave_like "a Reader class"

    let(:file){
      File.expand_path('../input.ruby', __FILE__)
    }
    let(:reader){
      Reader::Ruby.new(file)
    }

    let(:expected){
      [
        {:id => 1},
        {:id => 2}
      ]
    }

    it "should be enumerable" do
      expect(reader.to_a).to eq(expected)
    end

  end
end
