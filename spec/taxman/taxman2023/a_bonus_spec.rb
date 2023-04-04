# frozen_string_literal: true

RSpec.describe Taxman2023::ABonus do
  let(:a) do
    described_class.new(
      a: a_term,
      current_bonus_term: current_bonus_term,
      ytd_bonus_term: ytd_bonus_term
    ).amount
  end

  let(:a_term) do
    Taxman2023::A.new(
      p: p, # Number of pay periods
      i: i, # Regular income for the period, plus non-cash taxable benefits
      f: 0, # Contributions to an RRSP (i.e. pre-tax deductions)
      f2: 0, # Alimony or maintenance
      f5a: f5a, # CPP contribution deduction for regular income
      u1: 0, # union dues
      hd: 0, # prescribed zone from TD1
      f1: 0 # child care and support
    )
  end

  let(:current_bonus_term) do
    Taxman2023::CurrentBonusTerm.new(
      b: b,
      f3: 0,
      f5b: f5b
    )
  end

  let(:ytd_bonus_term) do
    Taxman2023::YtdBonusTerm.new(
      b1: b1,
      f4: 0,
      f5b_ytd: f5b_ytd
    )
  end

  # see https://docs.google.com/spreadsheets/d/1GwlJj9_1ilsRuOV5qPsQY-qFWXqkEEGzeshSq-sgjRg/edit#gid=1688629913
  context "with a much larger bonus than periodic income" do
    let(:p) { 26 } # Biweekly
    let(:i) { 3_076_92 }
    let(:cpp) { 1_461_40.0.to_d }
    let(:f5) { cpp * (0.01.to_d / 0.0595.to_d) }
    let(:f5a) { f5 * (i / (i + b)) }
    let(:f5b) { f5 * (b / (i + b)) }
    let(:b) { 21_619_00.to_d }
    let(:b1) { 0 }
    let(:f5b_ytd) { 0 }

    it "matches PDOC/Greg's sheet" do
      expect(a).to be_within(0.01).of 100_608_26.83.to_d
    end
  end

  # see https://docs.google.com/spreadsheets/d/1q0tv_4IMqdL23wLRg49VikhXRC5tsy7oxGc5at71fzw/edit#gid=428627088
  context "with a very large income" do
    let(:p) { 24 }
    let(:i) { 8_750_00 }
    let(:cpp) { 1_404_45.0.to_d }
    let(:f5) { cpp * (0.01.to_d / 0.0595.to_d) }
    let(:f5a) { f5 * (i / (i + b)) }
    let(:f5b) { f5 * (b / (i + b)) }
    let(:b) { 15_000_00.to_d }
    let(:b1) { 0 }
    let(:f5b_ytd) { 0 }

    it "matches PDOC/Greg's sheet" do
      expect(a).to be_within(0.1).of 222_763_81.25.to_d
    end
  end

  # see https://docs.google.com/spreadsheets/d/1q0tv_4IMqdL23wLRg49VikhXRC5tsy7oxGc5at71fzw/edit#gid=1592630299
  context "with cpp and ei maxed" do
    let(:p) { 52 }
    let(:i) { 3_000_00 }
    let(:cpp) { 0 }
    let(:f5) { 0 }
    let(:f5a) { 0 }
    let(:f5b) { 0 }
    let(:b) { 5_000_00 }
    let(:b1) { 1_000_00 }
    let(:f5b_ytd) { 9_63 }

    it "matches PDOC/Greg's sheet" do
      expect(a).to be_within(0.1).of 161_990_37.to_d
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
