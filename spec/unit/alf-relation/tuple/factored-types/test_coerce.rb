require 'spec_helper'
module Alf
  describe Tuple, '.coerce' do

    let(:type) { Tuple[name: String,  status: Integer] }

    subject{ type.coerce(tuple) }

    context 'on single attributes' do
      let(:tuple){ {'name' => "Jones", 'status' => "20"} }

      it 'coerces the attributes' do
        subject.should eq(Tuple(name: "Jones", status: 20))
      end
    end

    context 'with a wrapped tuple-valued attribute' do
      let(:type){ Tuple[name: String,  hobbies: Tuple[name: String, major: Boolean]] }
      let(:tuple){ {'name' => "Smith", 'hobbies' => {'name' => "Programming", "major" => "true"} } }

      it 'coerces wrapped attributes' do
        subject.should eq(Tuple(name: "Smith", hobbies: Tuple(name: "Programming", major: true)))
      end
    end

    context 'with a DUM RVA' do
      let(:type){ Tuple[sid: String, supplies: Relation[{}]] }
      let(:tuple){ Tuple(sid: "S5", supplies: Alf::Relation([])) }

      it{ should be(tuple) }
    end

    context 'from a Tuple whose declared type hides the compatibility' do
      let(:type) { Tuple[price: Integer] }
      let(:tuple){ Tuple[price: Numeric].new(price: 12) }

      it{ should eq(type.new(price: 12))}
    end

    context 'on coercion failure' do
      let(:tuple){ {name: "Jones", status: "bar"} }

      it 'raises an error' do
        lambda{
          subject
        }.should raise_error(TypeError, /Unable to coerce `"bar"` to `Integer`/)
      end
    end

    context 'on missing attribute' do
      let(:tuple){ {name: "Jones"} }

      it 'raises an error' do
        lambda{
          subject
        }.should raise_error(TypeError, /Missing attribute `status`/)
      end
    end

    context 'on missing attributes' do
      let(:tuple){ {} }

      it 'raises an error' do
        lambda{
          subject
        }.should raise_error(TypeError, /Missing attributes `name, status`/)
      end
    end

    context 'on too much attribute' do
      let(:tuple){ {name: "Jones", status: 10, foo: "bar"} }

      it 'raises an error' do
        lambda{
          subject
        }.should raise_error(TypeError, /Unexpected attribute `foo`/)
      end
    end

    context 'on too much attributes' do
      let(:tuple){ {name: "Jones", status: 10, foo: "bar", foo2: "blah"} }

      it 'raises an error' do
        lambda{
          subject
        }.should raise_error(TypeError, /Unexpected attributes `foo, foo2`/)
      end
    end

  end
end
