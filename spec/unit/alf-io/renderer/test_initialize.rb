require 'spec_helper'
module Alf
  describe "Renderer#initialize" do

    subject{ Renderer.new(*args) }

    describe "with full args" do
      let(:args){[ [], {:opts => true} ]}
      specify {
        expect(subject.input).to eq([])
        expect(subject.options).to eq(:opts => true)
      }
    end

    describe "on a subclass" do
      class FooRenderer < Renderer
        DEFAULT_OPTIONS = {:from => :subclass}
      end
      subject{ FooRenderer.new(*args) }

      describe "without option overriding" do
        let(:args){[ [], {:opts => true} ]}
        specify {
          expect(subject.input).to eq([])
          expect(subject.options).to eq(:opts => true, :from => :subclass)
        }
      end

      describe "with option overriding" do
        let(:args){[ [], {:opts => true, :from => :overrided} ]}
        specify {
          expect(subject.input).to eq([])
          expect(subject.options).to eq(:opts => true, :from => :overrided)
        }
      end

    end

  end
end
