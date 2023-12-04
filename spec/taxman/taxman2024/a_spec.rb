# frozen_string_literal: true

RSpec.describe Taxman2024::A do
  let(:a) do
    described_class
      .new(
        p: p, # Number of pay periods
        i: i, # Regular income for the period, plus non-cash taxable benefits
        f: f, # Contributions to an RRSP (i.e. pre-tax deductions)
        f2: f2, # Alimony or maintenance
        f5a: f5a, # CPP contribution deduction for regular income
        u1: u1, # union dues
        hd: hd, # prescribed zone from TD1
        f1: f1 # child care and support
      )
      .amount
  end
  let(:i) { 4_500_00 } # Income
  let(:f) { 0 }
  let(:f2) { 0 }
  let(:f5a) { 0 } # When there is no bonus, f5a just equals f5
  let(:u1) { 0 }
  let(:hd) { 0 }
  let(:f1) { 0 }

  context "with twelve pay periods" do
    let(:p) { 12 }

    it "multiplies the period income by twelve" do
      expect(a).to eq 4_500_00 * 12
    end
  end

  context "with a per period deduction" do
    let(:p) { 12 }
    let(:f) { 100_00 }

    it "removes the deduction amount from each period" do
      expect(a).to eq 4_400_00 * 12
    end
  end

  context "with an overall deduction" do
    let(:p) { 12 }
    let(:hd) { 1_000_00 }

    it "removes the deduction from the total" do
      expect(a).to eq (4_500_00 * 12) - 1_000_00
    end
  end
end
