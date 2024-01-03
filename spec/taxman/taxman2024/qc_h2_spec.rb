# frozen_string_literal: true

RSpec.describe Taxman2024::QcH2 do
  let(:qc_h2) do
    described_class
      .new(
        qc_d1: qc_d1,
        qc_h1: qc_h1,
        qc_pr: qc_pr
      )
      .amount
  end

  context "with no prior YTD H (qc_h1)" do
    let(:qc_d1) { 25_000_00 }
    let(:qc_h1) { 0 }
    let(:qc_pr) { 12 }

    it "matches implementation spreadsheet" do
      expect(qc_h2.round).to eq(115_00)
    end
  end

  context "with maxed YTD H (qc_h1)" do
    let(:qc_d1) { 25_000_00 }
    let(:qc_h1) { Taxman2024::QcH::EMPLOYMENT_INCOME_MAXIMUM_DEDUCTION }
    let(:qc_pr) { 12 }

    it "matches expecation" do
      expect(qc_h2.round).to eq(0)
    end
  end

  context "with maxed YTD H (qc_h1) less 100" do
    let(:qc_d1) { 25_000_00 }
    let(:qc_h1) { Taxman2024::QcH::EMPLOYMENT_INCOME_MAXIMUM_DEDUCTION - 100_00 }
    let(:qc_pr) { 12 }

    it "matches expectation" do
      expect(qc_h2.round).to eq(100_00 / 12)
    end
  end
end
