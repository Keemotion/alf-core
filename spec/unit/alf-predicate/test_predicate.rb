require 'spec_helper'

shared_examples_for "a predicate" do

  let(:x){ 12 }
  let(:y){ 13 }

  it 'provides a proc for easy evaluation' do
    got = subject.to_proc.call(Tuple(x: 12, y: 13))
    expect([ TrueClass, FalseClass ]).to include(got.class)
  end

  it 'can be negated easily' do
    expect((!subject)).to be_a(Alf::Predicate)
  end

  it 'detects stupid AND' do
    expect((subject & Alf::Predicate.tautology)).to be(subject)
  end

  it 'detects stupid OR' do
    expect((subject | Alf::Predicate.contradiction)).to be(subject)
  end

  it 'has free variables' do
    expect((fv = subject.free_variables)).to be_kind_of(Alf::AttrList)
    expect(fv - Alf::AttrList[ :x, :y ]).to be_empty
  end

  it 'always splits around and trivially when no free variables are touched' do
    top, down = subject.and_split(Alf::AttrList[:z])
    expect(top).to be_tautology
    expect(down).to eq(subject)
  end

end

module Alf

  describe 'Predicate.tautology' do
    subject{ Predicate.tautology }

    it_should_behave_like "a predicate"
  end

  describe 'Predicate.contradiction' do
    subject{ Predicate.contradiction }

    it_should_behave_like "a predicate"
  end

  describe "Predicate.comp" do
    subject{ Predicate.comp(:lt, {:x => 2}) }

    it_should_behave_like "a predicate"
  end

  describe "Predicate.in" do
    subject{ Predicate.in(:x, [2, 3]) }

    it_should_behave_like "a predicate"
  end

  describe "Predicate.among" do
    subject{ Predicate.among(:x, [2, 3]) }

    it_should_behave_like "a predicate"
  end

  describe "Predicate.eq" do
    subject{ Predicate.eq(:x, 2) }

    it_should_behave_like "a predicate"
  end

  describe "Predicate.neq" do
    subject{ Predicate.neq(:x, 2) }

    it_should_behave_like "a predicate"
  end

  describe "Predicate.gt" do
    subject{ Predicate.gt(:x, 2) }

    it_should_behave_like "a predicate"
  end

  describe "Predicate.gte" do
    subject{ Predicate.gte(:x, 2) }

    it_should_behave_like "a predicate"
  end

  describe "Predicate.lt" do
    subject{ Predicate.lt(:x, 2) }

    it_should_behave_like "a predicate"
  end

  describe "Predicate.lte" do
    subject{ Predicate.lte(:x, 2) }

    it_should_behave_like "a predicate"
  end

  describe "Predicate.between" do
    subject{ Predicate.between(:x, 2, 3) }

    it_should_behave_like "a predicate"
  end

  describe "Predicate.and" do
    subject{ Predicate.and(Predicate.eq(:x, 12), Predicate.eq(:y, 12)) }

    it_should_behave_like "a predicate"
  end

  describe "Predicate.or" do
    subject{ Predicate.or(Predicate.eq(:x, 12), Predicate.eq(:y, 12)) }

    it_should_behave_like "a predicate"
  end

  describe "Predicate.not" do
    subject{ Predicate.not(Predicate.in(:x, [12])) }

    it_should_behave_like "a predicate"
  end

end
