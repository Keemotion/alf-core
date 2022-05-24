require 'spec_helper'
module Alf
  module Support
    describe Scope, "evaluate" do

      context 'on a scope with helpers' do
        let(:scope) { Scope.new [ HelpersInScope ] }

        it 'has available helpers in scope' do
          expect(scope.evaluate{ hello(world) }).to eq("Hello world!")
        end

        it 'supports a string' do
          expect(scope.evaluate("hello(world)")).to eq("Hello world!")
        end

        it 'supports traceability on errors' do
          begin
            scope.evaluate("no_such_one", "a file", 65)
            raise "Should not pass here"
          rescue NameError => ex
            expect(ex.backtrace.any?{|l| l =~ /a file:65/}).to be_truthy
          end
        end
      end

      context 'on a scope with a parent' do
        let(:here) { Module.new{ def here; 'here'; end } }
        let(:scope){ Scope.new [ here ], Scope.new([ HelpersInScope ]) }

        it 'delegates to the parent' do
          expect(scope.evaluate{ hello(world) }).to eq("Hello world!")
        end

        it 'correctly respect the priorities' do
          expect(scope.evaluate{ hello(here) }).to eq("Hello here!")
        end
      end

    end
  end
end
