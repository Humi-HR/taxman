# frozen_string_literal: true

RSpec.describe Taxman2024::QcCs do
  let(:qc_cs) do
    described_class
      .new(
        qc_c: qc_c,
        qc_c2: 0
      )
      .amount
  end
  let(:qc_c) { 101_00 }

  it "calculates" do
    expect(qc_cs).to be_positive
  end

  it "is less than c" do
    expect(qc_cs).to be < qc_c
  end

  context "with c2" do
    let(:qc_c2) { 10 }
    let(:qc_cs_with_c2) do
      described_class
        .new(
          qc_c: qc_c,
          qc_c2: qc_c2
        )
        .amount
    end

    it "adds c2" do
      expect(qc_cs_with_c2).to eq qc_cs + qc_c2
    end
  end
end
