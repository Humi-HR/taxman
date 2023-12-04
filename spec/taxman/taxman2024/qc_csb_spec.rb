# frozen_string_literal: true

RSpec.describe Taxman2024::QcCsb do
  let(:qc_csb) do
    described_class
      .new(
        qc_cs: qc_cs,
        qc_s3: qc_s3,
        qc_b2: qc_b2
      )
      .amount
  end
  let(:qc_cs) { 247_08.3333 }
  let(:qc_s3) { 25_000_00 }
  let(:qc_b2) { 20_000_00 }

  it "calculates" do
    expect(qc_csb.round).to eq(197_67)
  end

  context "when qc_s3 is zero" do
    let(:qc_s3) { 0 }

    it "returns zero" do
      expect(qc_csb).to be_zero
    end
  end
end
