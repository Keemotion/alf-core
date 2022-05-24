require 'spec_helper'
module Alf
  module Lang
    describe ObjectOriented do
      include ObjectOriented.new(supplier_names_relation)

      Renderer.each do |name,_,clazz|

        describe "#to_#{name}" do
          subject{ :"to_#{name}" }
          it 'should exist' do
            meths = ObjectOriented.instance_methods.map(&:to_sym)
            expect(meths).to include(subject)
          end

          it 'returns a string by default' do
            expect(send(subject)).to be_kind_of(String)
          end

          it 'renders the values at first glance' do
            expect(send(subject)).to match(/Adams/)
          end

          it 'returns the passed IO if any' do
            io = StringIO.new
            expect(send(subject, io)).to eq(io)
          end

          it 'supports options' do
            io = StringIO.new
            expect(send(subject, {:sort => [:name]}, io)).to eq(io)
          end
        end

      end
    end
  end
end
