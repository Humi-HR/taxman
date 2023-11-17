# frozen_string_literal: true

RSpec.describe Taxman2023::QcCsa do
  let(:qc_csa) do
    described_class
      .new(
        qc_cs: qc_cs,
        qc_s3: qc_s3,
        qc_b2: qc_b2
      )
      .amount
  end
  let(:qc_cs) { 15_00 }
  let(:qc_s3) { 3_00 }
  let(:qc_b2) { 2_00 }

  it "calculates" do
    expect(qc_csa).to be_positive
  end

  context "when qc_s3 is zero" do
    let(:qc_s3) { 0 }

    it "returns zero" do
      expect(qc_csa).to be_zero
    end
  end
end
