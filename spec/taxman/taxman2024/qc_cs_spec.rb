# frozen_string_literal: true

RSpec.describe Taxman2024::QcCs do
  let(:qc_cs) do
    described_class
      .new(
        qc_c: qc_c
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
end
