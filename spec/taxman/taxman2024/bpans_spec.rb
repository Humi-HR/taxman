# frozen_string_literal: true

RSpec.describe Taxman2024::Bpans do
  let(:bpans) { described_class.new(a: a).amount }

  context "when annualized income is less than or equal to $25,000" do
    let(:a) { 25_000_00.to_d }

    it "equals $11,481" do
      expect(bpans).to eq 11_481_00
    end
  end

  context "when annualized income is greather than or equal to $75,000" do
    let(:a) { 75_000_00.to_d }

    it "equals $8,481" do
      expect(bpans).to eq 8_481_00
    end
  end

  context "when annualized income is in between the thresholds" do
    let(:a) { 50_000_00.to_d }

    it "equals the correct in between value" do
      expect(bpans).to eq 9_981_00.to_d
    end
  end
end
