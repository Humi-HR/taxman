# frozen_string_literal: true

RSpec.describe Taxman2024::Bc::T2 do
  let(:t2) { described_class.new(a: a, t4: t4).amount }

  context "when income is lower than $23,179" do
    let(:t4) { described_class::S2 }
    let(:a) { 20_000_00 }

    it "subtracts the lesser of t4 and s2" do
      expect(t2).to be_zero
    end
  end

  context "when income is higher than $37,814" do
    let(:a) { 40_000_00 }
    let(:t4) { 5_000_00 }

    it "is equal to t4" do
      expect(t2).to eq t4
    end
  end
end
