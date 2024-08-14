require 'spec_helper'
module Alf
  module Algebra
    describe Signature, '.install' do

      let(:clazz){ Class.new(Object) }
      subject{ signature.install }

      describe "on an empty signature" do
        let(:signature){ Signature.new(clazz) }
        it{ should eq({}) }
        specify{
          expect{ subject }.to_not raise_error
        }
      end

      describe "on a non empty signature" do

        let(:signature){
          Signature.new(clazz) do |s|
            s.argument :attrname, AttrName
            s.argument :ordering, Ordering
            s.option   :allbut,   Boolean, true
          end
        }

        it{ should eq(:allbut => true) }

        it "should have arguments installed as attr accessors" do
          subject
          inst = clazz.new
          expect(inst).to respond_to(:attrname)
          inst.send(:"attrname=", :hello)
          expect(inst.attrname).to eq(:hello)
        end

        it "should have options installed as attr accessors" do
          subject
          inst = clazz.new
          expect(inst).to respond_to(:allbut)
          inst.send(:"allbut=", true)
          expect(inst.allbut).to be_truthy
        end

        it "should apply auto-coercion" do
          subject
          inst = clazz.new
          inst.send(:"allbut=", "true")
          expect(inst.allbut).to be_truthy
        end

      end

    end
  end
end
