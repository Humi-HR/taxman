# frozen_string_literal: true

RSpec.describe Taxman2024::QcH do
  let(:qc_h) do
    described_class
      .new(
        qc_d: qc_d,
        p: p
      )
      .amount
  end
  let(:qc_d) { 5_000_00 }
  let(:p) { 12 }

  it "calculates" do
    expect(qc_h.to_f.truncate).to eq(115_00)
  end

  context "with large d" do
    let(:qc_d) { 4_500_00 * 100 }

    it "maxes out" do
      expect(qc_h).to eq(described_class.amount(qc_d: qc_d * 10, p: p))
    end
  end
end
