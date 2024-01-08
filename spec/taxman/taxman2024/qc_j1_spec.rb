# frozen_string_literal: true

RSpec.describe Taxman2024::QcJ1 do
  let(:qc_j1) do
    described_class
      .new(
        p: p,
        qc_pr: qc_pr,
        qc_j1_raw: qc_j1_raw,
        qc_j1_calc: qc_j1_calc
      )
  end
  let(:p) { 24 }
  let(:qc_pr) { 12 }
  let(:qc_j1_raw) { 0 }
  let(:qc_j1_calc) { 0 }

  it "with no user deduction" do
    expect(qc_j1.amount).to be_zero
  end

  context "with previously calculated deduction" do
    let(:qc_j1_raw) { 777_77 } # Should not be used here
    let(:qc_j1_calc) { 500_00 }

    it "get the previous deduction" do
      expect(qc_j1.amount).to eq qc_j1_calc
    end

    it "hs no new deduction" do
      expect(qc_j1.calc).to be_nil
    end
  end

  context "with not calculated deduction" do
    let(:qc_j1_raw) { 2_000_00 }

    it "calculates new deduction for tax calculation" do
      expect(qc_j1.amount).to eq(4_000_00)
    end

    it "calculates new deduction for storing" do
      expect(qc_j1.calc).to eq(4_000_00)
    end
  end

  context "with calculated deduction but no raw one" do
    let(:qc_j1_calc) { 100_00 }

    it "is zero" do
      expect(qc_j1.amount).to be_zero
    end
  end
end
