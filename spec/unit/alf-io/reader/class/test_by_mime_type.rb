require 'spec_helper'
module Alf
  describe Reader, ".by_mime_type" do

    let(:io){ StringIO.new("") }

    context 'when mime type is unrecognized' do
      subject{
        Reader.by_mime_type("no/suchone", io)
      }

      it 'should raise an error' do
        expect{
          subject
        }.to raise_error(UnsupportedMimeTypeError, /No reader for `no\/suchone`/)
      end
    end

    context 'when such mime type is registered' do
      subject{
        Reader.by_mime_type("text/csv", io)
      }

      it{ should be_a(Reader::CSV) }

      it 'should be wired correctly' do
        expect(subject.input).to be(io)
      end
    end

  end
end
