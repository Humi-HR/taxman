# frozen_string_literal: true

RSpec.describe Taxman2023::Nl::T4 do
  let(:t4) { described_class.new(a: a, hd: 0, tcp: tcp, k2p: k2p, k3p: k3p).amount }
  let(:a) { 0 } # Annualized income (comes from `a` calculator)
  let(:b) { 0 } # Taxable non periodic income in the period
  let(:b1) { 0 } # YTD Bonus income
  let(:p) { 12 } # Number of periods in the year
  let(:tcp) { nil } # Provincial personal exemption, nil to use the table
  let(:k3p) { 0 } # Other non-refundable provincial tax credits
  let(:d) { 0 } # YTD CPP contribution
  let(:d1) { 0 } # YTD EI contribution

  let(:k2_params) do
    {
      pi: i,
      pi_periodic: i - b,
      b_pensionable: b,
      b1_pensionable: b1,
      ie: i,
      ie_periodic: i - b,
      b_insurable: b,
      b1_insurable: b1,
      p: p,
      d: d,
      d1: d1
    }
  end

  context "with no income in the period" do
    let(:k2p) { 0 }

    it "calculates no taxes owing" do
      expect(t4).to be_zero
    end
  end

  context "with $84k salary" do
    let(:i) { 7_000_00 }
    let(:b) { 0 }
    let(:b1) { 0 }
    let(:p) { 12 }
    let(:f5a) { 399_15.to_d * (0.01 / 0.0595) } # F5=C*(0.01/0.0595) C from PDOC
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

    let(:k2p) { Taxman2023::Nl::K2p.new(**k2_params).amount }

    # https://docs.google.com/spreadsheets/d/1Kh9TLeYrnnqyr7BkKyuFyAWDOvkUvAlBzFAKLBB3VeQ/edit#gid=562910102
    it "calculates an annualized provincial tax deduction of $8,400.62" do
      expect(t4).to be_within(0.1).of 8_400_62.16.to_d
    end
  end
end
