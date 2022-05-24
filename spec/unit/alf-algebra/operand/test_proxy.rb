require 'spec_helper'
module Alf
  module Algebra
    module Operand
      describe Proxy do

        DELEGATED = [ :heading, :keys ]

        subject{
          Proxy.new(victim).send(method)
        }

        DELEGATED.each do |method|
          context "with #{method} with knowing victim" do
            let(:method){
              method
            }
            let(:victim){
              Struct.new(method).new("foo")
            }

            before do
              expect(victim).to respond_to(method)
            end

            it "should delegate it" do
              expect(subject).to eq("foo")
            end
          end

          context "with #{method} with unknowing victim" do
            let(:method){
              method
            }
            let(:victim){
              Object.new
            }

            before do
              expect(victim).to_not respond_to(method)
            end

            it "should raise a NotSupportedError" do
              expect(lambda{
                subject
              }).to raise_error(NotSupportedError)
            end
          end
        end

      end
    end
  end
end
