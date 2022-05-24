require 'spec_helper'
module Alf
  module Algebra
    describe Relational do

      specify "each" do
        x = []
        Relational.each{|m| x << m}
        expect(x.sort{|m1,m2| m1.name.to_s <=> m2.name.to_s}).to eq([
          Allbut,
          Extend,
          Frame,
          Group,
          Hierarchize,
          Image,
          Intersect,
          Join,
          Matching,
          Minus,
          NotMatching,
          Page,
          Project,
          Quota,
          Rank,
          Rename,
          Restrict,
          Summarize,
          Ungroup,
          Union,
          Unwrap,
          Wrap,
        ])
      end

    end
  end
end
