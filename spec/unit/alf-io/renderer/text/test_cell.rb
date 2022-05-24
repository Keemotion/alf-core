require 'spec_helper'
module Alf
  class Renderer::Text
    describe Cell do

      let(:f){ Cell.new }

      specify "text_rendering" do
        expect(Cell.new(100).text_rendering).to eq("100")
        expect(Cell.new(:hello).text_rendering).to eq(":hello")
        expect(Cell.new("hello").text_rendering).to eq("hello")
        expect(Cell.new(10.0).text_rendering).to eq("10.000")
        expect(Cell.new(10/3.0).text_rendering).to eq("3.333")
        expect(Cell.new([]).text_rendering).to eq("[]")
        expect(Cell.new([10/3.0, true]).text_rendering).to eq("[3.333, true]")
        expect(Cell.new(10/3.0, {:float_format => "%.6f"}).text_rendering).to eq("3.333333")
      end

      specify "min_width" do
        expect(Cell.new("").min_width).to eq(0)
        expect(Cell.new(10/3.0).min_width).to eq(5)
        expect(Cell.new("12\n5345").min_width).to eq(4)
      end

      specify "rendering_lines" do
        expect(Cell.new("").rendering_lines).to eq([])
        expect(Cell.new(10/3.0).rendering_lines).to eq(["3.333"])
        expect(Cell.new([10/3.0,true]).rendering_lines).to eq(["[3.333, true]"])
        expect(Cell.new("abc").rendering_lines(5)).to eq(["abc  "])
        expect(Cell.new(12).rendering_lines(5)).to eq(["   12"])
      end

    end
  end
end
