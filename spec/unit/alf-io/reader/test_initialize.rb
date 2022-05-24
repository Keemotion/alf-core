require 'spec_helper'
module Alf
  describe "Reader#initialize" do

    subject{ Reader.new(*args) }

    let(:input){ nil }
    let(:options){ nil }

    let(:args){ [input, options].compact }

    before do
      expect(subject).to be_kind_of(Reader)
    end

    after do
      expect(subject.input).to eq(input)
    end

    context 'with empty default options' do

      after do
        expect(subject.options).to eq(options || {})
      end

      context "with only a path as a String" do
        let(:input){ "suppliers" }
        it 'should set the path correctly' do
          expect(subject.path).to eq(Path("suppliers"))
        end
      end

      context "with only a path as a Path" do
        let(:input){ Path("suppliers") }
        it 'should set the path correctly' do
          expect(subject.path).to eq(Path("suppliers"))
        end
      end

      context "with a File" do
        let(:input){ Path.file.open('r') }
        it 'should set the path correctly' do
          expect(subject.path).to eq(Path.file)
        end
        after{ input.close rescue nil }
      end
    end

    describe "on a subclass" do
      class FooReader < Reader
        DEFAULT_OPTIONS = {:from => :subclass}
      end
      subject{ FooReader.new(*args) }

      let(:input){ "suppliers" }

      describe "without option overriding" do
        let(:options){ {:opts => true} }
        it 'should merge options' do
          expect(subject.options).to eq(:opts => true, :from => :subclass)
        end
      end

      describe "with option overriding" do
        let(:options){ {:opts => true, :from => :overrided} }
        it 'should override options' do
          expect(subject.options).to eq(:opts => true, :from => :overrided)
        end
      end

    end

  end
end
