# frozen_string_literal: true

RSpec.describe Taxman2024::QcY1Y2 do
  let(:params) do
    {
      qc_i1: qc_i1,
      qc_b1: qc_b1,
      qc_b2: qc_b2,
      qc_csb1: qc_csb1,
      qc_csb: qc_csb,
      qc_k1: 0,
      qc_e: qc_e,
      p: 12,
      qc_q: 0,
      qc_q1: 0
    }
  end
  let(:qc_y1_y2) { described_class.amount(params) }
  let(:qc_i1) { 0 }
  let(:qc_b1) { 0 }
  let(:qc_b2) { 0 }
  let(:qc_csb1) { 0 }
  let(:qc_csb) { 0 }
  let(:qc_e) { 17_183_00 }

  context "with no annual income" do
    it "calculates no taxes owing" do
      expect(qc_y1_y2).to be_zero
    end
  end

  context "with annual income and no b2 or csb" do
    let(:qc_i1) { 58_092_00 }

    it "calculates y1" do
      expect(qc_y1_y2).to eq(6_168_86)
    end
  end

  context "with annual income and b2 and csb" do
    let(:qc_i1) { 58_092_00 }
    let(:qc_csb) { 197_66.6667 }
    let(:qc_b2) { 20_000_00 }

    it "calculates y2" do
      expect(qc_y1_y2.round).to eq(9_931_30)
    end
  end
end
