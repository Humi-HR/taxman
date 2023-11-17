# frozen_string_literal: true

RSpec.describe Taxman2024::QcA do
  let(:params) { { qc_y: qc_y, p: 12, qc_l: qc_l } }
  let(:qc_a) { described_class.amount(params) }
  let(:qc_y) { 0 }
  let(:qc_l) { 0 }

  context "with no income tax for year" do
    it "calculates no income tax for period" do
      expect(qc_a).to be_zero
    end
  end

  context "with income tax for year" do
    let(:qc_y) { 6_168_86 }

    it "calculates income tax for period" do
      expect(qc_a.to_f.truncate).to eq(514_07)
    end

    context "with additional source deduction" do
      let(:qc_l) { 100_00 }

      it "adds additional source deduction" do
        expect(qc_a.to_f.truncate).to eq(614_07)
      end
    end
  end
end
