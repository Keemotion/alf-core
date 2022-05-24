require 'spec_helper'
module Alf
  describe "Support#to_ruby_literal" do

    it 'works on Symbols' do
      expect(Support.to_ruby_literal(:name)).to eql(":name")
    end

    it 'works on Integers' do
      expect(Support.to_ruby_literal(12)).to eql("12")
    end

    it 'works on DateTime' do
      dt = DateTime.parse('2012-05-11T12:00:00+00:00')
      rl = Support.to_ruby_literal(dt)
      expect(::Kernel.eval(rl)).to eq(dt)
    end

    it 'works on Time' do
      t = Time.parse('2012-05-11T12:00:00+00:00')
      rl = Support.to_ruby_literal(t)
      expect(::Kernel.eval(rl)).to eq(t)
    end

  end
end
