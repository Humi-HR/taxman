# frozen_string_literal: true

RSpec.describe Taxman2024::Bc::T2 do
  let(:t2) { described_class.new(a: a, t4: t4).amount }

  context "when income is lower than $24,338" do
    let(:t4) { described_class::S2 }
    let(:a) { 24_000_00 }

    it "subtracts the lesser of t4 and s2" do
      expect(t2).to be_zero
    end
  end

  context "when income is higher than $39,703" do
    let(:a) { 39_800_00 }
    let(:t4) { 5_000_00 }

    it "is equal to t4" do
      expect(t2).to eq t4
    end
  end
end
