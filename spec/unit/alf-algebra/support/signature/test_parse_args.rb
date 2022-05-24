require 'spec_helper'
module Alf
  module Algebra
    describe Signature, "#parse_args" do

      class FakeOp
        attr_accessor :operands
      end
      let(:receiver){ FakeOp.new }

      let(:operand){ an_operand }

      before{
        signature.install
      }
      subject{
        signature.parse_args(args, receiver)
      }

      context "on a signature with arguments only" do
        let(:signature){
          Signature.new(FakeOp) do |s|
            s.argument :proj, AttrList
          end
        }
        let(:args){ [ [operand], ["hello", "world"] ] }

        it 'should return the receiver' do
          expect(subject).to eq(receiver)
        end

        it "should set the operands" do
          expect(subject.operands).to eq([operand])
        end

        it 'should set the arguments' do
          expect(subject.proj).to eq(AttrList[:hello, :world])
        end
      end # arguments only

      context "with default values for arguments" do
        let(:signature){
          Signature.new(FakeOp) do |s|
            s.argument :attrname, AttrName, :autonum
          end
        }

        context 'and passed' do
          let(:args){ [[operand], "hello"] }

          it 'should not use the default value' do
            expect(subject.attrname).to eq(:hello)
          end
        end

        context 'and not passed' do
          let(:args){ [[operand]] }

          it 'should use the default value' do
            expect(subject.attrname).to eq(:autonum)
          end
        end
      end # default values for arguments

      context "on a signature with options" do
        let(:signature){
          Signature.new(FakeOp) do |s|
            s.argument :key, AttrList, []
            s.option   :allbut, Boolean, false
          end
        }

        context "when no option is provided" do
          let(:args){ [[operand], [:hello, :world]] }

          it 'should use the default values for options' do
            expect(subject.allbut).to eql(false)
          end
        end

        context "when option is provided" do
          let(:args){ [[operand], [:hello, :world], {:allbut => true}] }

          it 'should not use the default values for options' do
            expect(subject.allbut).to eql(true)
          end
        end
      end # signature with options

    end
  end
end
