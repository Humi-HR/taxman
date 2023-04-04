# frozen_string_literal: true

RSpec.describe Taxman2023::T3 do
  let(:t3) { described_class.new(a: a, hd: hd, k2: k2, tc: tc).amount }
  let(:hd) { 0 }
  let(:tc) { nil }

  let(:b) { 0 }
  let(:b1) { 0 }
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
      p: p
    }
  end

  context "with no income" do
    let(:a) { 0 }
    let(:k2) { 0 }

    it "calculates no taxes" do
      expect(t3).to be_zero
    end
  end

  context "with $54,000 a year income" do
    let(:i) { 4_500_00 }
    let(:p) { 12 }
    let(:a) do
      Taxman2023::A.new(
        p: 12,
        i: i,
        f: 0,
        f2: 0,
        f5a: 250_40 * (0.01 / 0.0595), # F5=C*(0.01/0.0595)=from pdoc
        u1: 0,
        hd: hd,
        f1: 0
      ).amount
    end
    let(:k2) { Taxman2023::K2.new(**k2_params).amount }

    it "calculates an annualized tax of $5,069.28" do
      expect(t3).to be_within(0.1).of 5_069_28 # This is from pdoc, they only give us cents
    end
  end

  context "with $210k yearly income" do
    let(:i) { 8_750_00 }
    let(:p) { 24 }
    let(:a) do
      Taxman2023::A.new(
        p: 24,
        i: 8_750_00,
        f: 0,
        f2: 0,
        f5a: 511_94.792.to_d * (0.01.to_d / 0.0595.to_d),
        u1: 0,
        hd: 0,
        f1: 0
      ).amount
    end

    let(:k2) { Taxman2023::K2.new(**k2_params).amount }

    it "calculates an annualized tax of $43,594.31" do
      expect(t3).to be_within(0.01).of 43_594_30.56.to_d
    end
  end
end
