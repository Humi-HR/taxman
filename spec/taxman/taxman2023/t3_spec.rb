# frozen_string_literal: true

RSpec.describe Taxman2023::T3 do
  let(:t3) { described_class.new(a: a, hd: hd, k2: k2).amount }
  let(:hd) { 0 }

  context "with no income" do
    let(:a) { 0 }
    let(:k2) { 0 }

    it "calculates no taxes" do
      expect(t3).to eq 0
    end
  end

  context "with $54,000 a year income" do
    let(:a) do
      Taxman2023::A.new(
        p: 12,
        i: 4_500_00,
        f: 0,
        f2: 0,
        f5a: 250_40 * (0.01 / 0.0595), # F5=C*(0.01/0.0595)=from pdoc
        u1: 0,
        hd: hd,
        f1: 0
      ).amount
    end
    let(:k2) { Taxman2023::K2.new(i: 4_500_00, b: 0, b1: 0, p: 12).amount }

    it "calculates an annualized tax of $5,069.28" do
      expect(t3).to be_within(0.1).of 5_069_28 # This is from pdoc, they only give us cents
    end
  end
end
