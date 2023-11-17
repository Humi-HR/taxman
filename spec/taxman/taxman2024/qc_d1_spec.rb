# frozen_string_literal: true

RSpec.describe Taxman2024::QcD1 do
  let(:qc_d1) do
    described_class
      .new(
        qc_d: qc_d,
        qc_b1: qc_b1,
        qc_b2: qc_b2,
        qc_g1: qc_g1
      )
      .amount
  end
  let(:qc_d) { 1_100_00 }
  let(:qc_b1) { 2_200_00 }
  let(:qc_b2) { 3_300_00 }
  let(:qc_g1) { 4_400_00 }

  it "calculates" do
    expect(qc_d1).to eq(11_000_00)
  end
end
