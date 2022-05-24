require 'spec_helper'
module Alf
  module Algebra
    describe Signature, '.initialize' do

      subject{
        Signature.new(nil){|s|
          s.argument :name, AttrName, :autonum
          s.option :allbut, Boolean, true, "Applies an allbut projection?"
        }
      }

      it "yields the signature" do
        expect(subject.arguments).to eql([[:name, AttrName, :autonum, nil]])
        expect(subject.options).to eql([[:allbut, Boolean, true, "Applies an allbut projection?"]])
      end

    end
  end
end
