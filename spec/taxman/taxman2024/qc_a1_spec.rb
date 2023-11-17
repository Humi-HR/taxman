# frozen_string_literal: true

RSpec.describe Taxman2024::QcA1 do
  let(:params) { { qc_y1: qc_y1, qc_y2: qc_y2 } }
  let(:qc_a1) { described_class.amount(params) }
  let(:qc_y1) { 0 }
  let(:qc_y2) { 0 }

  context "with no current bonus" do
    let(:qc_y1) { 123 }
    let(:qc_y2) { 123 }

    it "calculates no income tax for period" do
      expect(qc_a1).to be_zero
    end
  end

  context "with current bonus" do
    let(:qc_y1) { 100 }
    let(:qc_y2) { 211 }

    it "calculates income tax for period" do
      expect(qc_a1).to eq(111)
    end
  end
end
