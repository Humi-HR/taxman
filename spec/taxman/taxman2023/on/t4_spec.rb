# frozen_string_literal: true

# rubocop:disable RSpec/MultipleMemoizedHelpers
RSpec.describe Taxman2023::On::T4 do
  let(:t4) { described_class.new(a: a, hd: 0, tcp: tcp, k2p: k2p, k3p: k3p).amount }
  let(:a) { 0 } # Annualized income (comes from `a` calculator)
  let(:b) { 0 } # Taxable non periodic income in the period
  let(:b1) { 0 } # YTD Bonus income
  let(:p) { 12 } # Number of periods in the year
  let(:tcp) { nil } # Provincial personal exemption, nil to use the table
  let(:k3p) { 0 } # Other non-refundable provincial tax credits

  context "with no income in the period" do
    let(:k2p) { 0 }

    it "calculates no taxes owing" do
      expect(t4).to be_zero
    end
  end

  context "with $54k salary" do
    let(:i) { 4_500_00 }
    let(:f5a) { 250_40 * (0.01 / 0.0595) } # F5=C*(0.01/0.0595) C from PDOC
    let(:a) do
      Taxman2023::A.new(
        p: 12,
        i: i,
        f: 0,
        f2: 0,
        f5a: f5a,
        u1: 0,
        hd: 0,
        f1: 0
      ).amount
    end

    let(:k2p) { Taxman2023::On::K2p.new(i: i, b: 0, b1: 0, p: 12).amount }

    # https://docs.google.com/spreadsheets/d/1q0tv_4IMqdL23wLRg49VikhXRC5tsy7oxGc5at71fzw/edit#gid=89378561
    it "calculates an annualized provincial tax deduction of $2,106.92" do
      expect(t4).to be_within(0.2).of 2_106_92.to_d
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
