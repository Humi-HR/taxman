# frozen_string_literal: true

RSpec.describe Taxman2024::T do
  context "when calculating taxes outside Quebec" do
    let(:t) { described_class.new(t1: 2_000_00, t2: 1_000_00, p: 12, l: 50_00, province: "ON").amount }

    it "divides the taxes among the periods" do
      expect(t).to eq 300_00.to_d
    end
  end

  context "when calculating taxes for Quebec" do
    let(:t) { described_class.new(t1: 2_000_00, t2: 1_000_00, p: 12, l: 50_00, province: "QC").amount }

    it "divides the taxes among the periods" do
      expect(t).to eq 216_66.to_d
    end
  end
end
