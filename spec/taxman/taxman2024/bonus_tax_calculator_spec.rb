# frozen_string_literal: true

RSpec.describe Taxman2024::BonusTaxCalculator do
  let(:context) do
    {
      p: 52,
      i: i,
      f: 0,
      f2: 0,
      f5a: 29_74.79,
      f5b: 49_57.98,
      f5b_ytd: 9_63,
      u1: 0,
      hd: 0,
      f1: 0,
      b: b,
      f3: 0,
      b1: 1_000_00,
      f4: 0,
      province: province,
      c: 472_00.to_d,
      k3: 0, # Other authorized per period federal deductions
      k3p: 0, # Other authorized per period provincial deductions
      l: 0,
      pi: i + b,
      pi_periodic: i,
      ie: i + b,
      ie_periodic: i,
      b_pensionable: b,
      b_insurable: b,
      b1_pensionable: 1_000_00,
      b1_insurable: 1_000_00,
      d: 0,
      d1: 0,
      moved_in_or_out_qc: false,
      pm: 0,
      ei: 0,
      dq: 0
    }
  end

  let(:bonus_tax) { described_class.new(context: context) }
  let(:province) { "ON" }

  # see https://docs.google.com/spreadsheets/d/1q0tv_4IMqdL23wLRg49VikhXRC5tsy7oxGc5at71fzw/edit#gid=1753621230
  context "with $3k a week, $5k of bonus and $1k of YTD bonus" do
    let(:i) { 3_000_00 }
    let(:b) { 5_000_00 }

    it "calculates the federal tax on the bonus" do
      expect(bonus_tax.calculate[:federal_tax_on_bonus]).to be_within(0.01).of 1_287.11.to_d
    end

    it "calculates the provincial tax on the bonus" do
      expect(bonus_tax.calculate[:provincial_tax_on_bonus]).to be_within(0.01).of 939.07.to_d
    end
  end

  context "with a annualized income of under $5k" do
    let(:i) { 75_00 }
    let(:b) { 123_00 }

    it "calculates a flat 10% federal tax on the bonus" do
      expect(bonus_tax.calculate[:federal_tax_on_bonus]).to be_within(0.1).of 12.30.to_d
    end

    it "calculates a flat 5% provincial tax on the bonus" do
      expect(bonus_tax.calculate[:provincial_tax_on_bonus]).to be_within(0.1).of 6.15.to_d
    end
  end
end
