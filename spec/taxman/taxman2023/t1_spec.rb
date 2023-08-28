# frozen_string_literal: true

RSpec.describe Taxman2023::T1 do
  let(:t1) { described_class.new(t3: t3, province: province).amount }

  context "with income not in Quebec" do
    let(:t3) { 1_000_00 }
    let(:province) { "BC" }

    it "calculates $1000 taxes" do
      expect(t1).to eq 1_000_00
    end
  end

  context "with income in Quebec" do
    let(:t3) { 1_000_00 }
    let(:province) { "QC" }

    it "calculates $1000 taxes" do
      expect(t1).to eq 835_00
    end
  end
end
