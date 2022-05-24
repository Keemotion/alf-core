require 'spec_helper'
module Alf
  describe Reader do

    subject{ Reader }
    it { should respond_to(:rash) }

    describe "rash on a real IO" do
      subject{ Reader.rash($stdin) }
      it{ should be_a(Reader::Rash) }
    end

    describe "reader" do

      specify "when associated" do
        r = Reader.reader('suppliers.rash')
        expect(r).to be_kind_of(Reader::Rash)
      end

      specify "when not associated" do
        expect(lambda{ Reader.reader('.noone') }).to raise_error(ArgumentError)
      end

      specify "when an IO" do
        expect(Reader.reader($stdin)).to be_kind_of(Reader::Rash)
      end

      specify "with options" do
        r = Reader.reader('suppliers.rash', {:hello => "world"})
        expect(r.options).to eq({:hello => "world"})
      end

    end

  end
end
