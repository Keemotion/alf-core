require 'spec_helper'
module Alf
  describe Relation do

    let(:rel1){ Alf::Relation(sid: ['S1', 'S2', 'S3']) }
    let(:rel2){ Alf::Relation(sid: ['S5', 'S2'])       }

    it 'should have all relational operators installed' do
      Algebra::Operator.each do |op|
        expect(rel1).to respond_to(op.rubycase_name)
      end
    end

    specify "project" do
      expect(rel1.project([])).to eq(Alf::Relation::DEE)
      expect(rel1.project([:sid], allbut: true)).to eq(Alf::Relation::DEE)
    end

    specify "allbut" do
      expect(rel1.allbut([:sid])).to eq(Alf::Relation::DEE)
    end

    specify "extend" do
      expect(rel1.extend(x: lambda{ sid.downcase })).to eq(Alf::Relation([
        {sid: 'S1', x: 's1'},
        {sid: 'S2', x: 's2'},
        {sid: 'S3', x: 's3'}
      ]))
    end

    specify "union" do
      expect((rel1 + rel1)).to eq(rel1)
      expect((rel1 | rel1)).to eq(rel1)
      expect((rel1 + rel2)).to eq(Alf::Relation(sid: ['S1','S3','S2','S5']))
    end # union

    specify "difference" do
      expect(rel1 - rel1).to eq(rel1.class.empty)
      expect(rel1 - rel2).to eq(Alf::Relation(sid: ['S1', 'S3']))
      expect(rel2 - rel1).to eq(Alf::Relation(sid: 'S5'))
    end # difference

    specify "join" do
      expect(rel1 * rel2).to eq(Alf::Relation(sid: 'S2'))
      expect(rel2 * rel1).to eq(Alf::Relation(sid: 'S2'))
    end # join

    specify "intersect" do
      expect((rel1 & rel2)).to eq(Alf::Relation(sid: 'S2'))
      expect((rel2 & rel1)).to eq(Alf::Relation(sid: 'S2'))
    end # intersect

    specify "matching" do
      expect(rel1 =~ rel2).to eq(Alf::Relation(sid: 'S2'))
    end # intersect

    specify "not matching" do
      expect(rel1 !~ rel2).to eq(Alf::Relation(sid: ['S1', 'S3']))
    end # intersect

    specify "page" do
      expect(rel1.page([[:sid, :asc]], 1, page_size: 2)).to eq(Alf::Relation(sid: ['S1', 'S2']))
      expect(rel1.page([[:sid, :asc]], -1, page_size: 2)).to eq(Alf::Relation(sid: ['S2', 'S3']))
      expect(rel1.page([[:sid, :asc]], 2, page_size: 2)).to eq(Alf::Relation(sid: ['S3']))
      expect(rel1.page([[:sid, :asc]], -2, page_size: 2)).to eq(Alf::Relation(sid: ['S1']))
    end

    specify "frame" do
      expect(rel1.frame([[:sid, :asc]], 1, 2)).to eq(Alf::Relation(sid: ['S2', 'S3']))
      expect(rel1.frame([[:sid, :asc]], 2, 12)).to eq(Alf::Relation(sid: ['S3']))
    end

  end
end
