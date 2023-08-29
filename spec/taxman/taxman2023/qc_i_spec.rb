# frozen_string_literal: true

RSpec.describe Taxman2023::QcI do
  let(:qc_i) do
    described_class
      .new(
        p: p,
        qc_g: qc_g,
        f: f,
        qc_h: qc_h,
        qc_csa: qc_csa,
        qc_j: qc_j,
        qc_j1: qc_j1
      )
      .amount
  end
  let(:p) { 12 }
  let(:qc_g) { 4_500_00 }
  let(:f) { 0 }
  let(:qc_h) { 0 }
  let(:qc_csa) { 0 }
  let(:qc_j) { 0 }
  let(:qc_j1) { 0 }

  it "multiplies the period income by number of periods" do
    expect(qc_i).to eq 4_500_00 * 12
  end

  context "with a per period deduction" do
    let(:f) { 100_00 }

    it "removes the deduction amount from each period" do
      expect(qc_i).to eq 4_400_00 * 12
    end
  end

  context "with an overall deduction" do
    let(:qc_j) { 1_000_00 }

    it "removes the deduction from the total" do
      expect(qc_i).to eq (4_500_00 * 12) - 1_000_00
    end
  end

  context "with deductions greater than income" do
    let(:qc_j) { (4_500_00 * 12)  + 1000}

    it "is zero" do
      expect(qc_i).to be_zero
    end
  end
end
