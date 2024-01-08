# frozen_string_literal: true

RSpec.describe Taxman2024::QcJ do
  let(:qc_j) do
    described_class
      .new(
        p: p,
        qc_pr: qc_pr,
        qc_j_raw: qc_j_raw,
        qc_j_calc: qc_j_calc
      )
  end
  let(:p) { 12 }
  let(:qc_pr) { 6 }
  let(:qc_j_raw) { 0 }
  let(:qc_j_calc) { 0 }

  it "with no user deduction" do
    expect(qc_j.amount).to be_zero
  end

  context "with previously calculated deduction" do
    let(:qc_j_raw) { 777_77 } # Should not be used here
    let(:qc_j_calc) { 100_00 }

    it "get the previous deduction" do
      expect(qc_j.amount).to eq qc_j_calc
    end

    it "hs no new deduction" do
      expect(qc_j.calc).to be_nil
    end
  end

  context "with not calculated deduction" do
    let(:qc_j_raw) { 1_000_00 }

    it "calculates new deduction for tax calculation" do
      expect(qc_j.amount).to eq(2_000_00)
    end

    it "calculates new deduction for storing" do
      expect(qc_j.calc).to eq(2_000_00)
    end
  end

  context "with calculated deduction but no raw one" do
    let(:qc_j_calc) { 100_00 }

    it "is zero" do
      expect(qc_j.amount).to be_zero
    end
  end
end
