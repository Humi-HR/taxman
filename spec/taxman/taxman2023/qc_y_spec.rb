# frozen_string_literal: true

RSpec.describe Taxman2023::QcY do
  let(:params) { { qc_i: qc_i, qc_k1: 0, qc_e: qc_e, p: 24, qc_q: 0, qc_q1: 0 } }
  let(:qc_y) { described_class.amount(params) }
  let(:qc_i) { 0 }
  let(:qc_e) { 0 }

  context "with no annual income" do
    it "calculates no taxes owing" do
      expect(qc_y).to be_zero
    end
  end

  context "with annual income" do
    let(:qc_i) { 90_000_00 }

    it "calculates taxes owing" do
      expect(qc_y).to be_positive
    end
  end

  context "with sufficient credits" do
    let(:qc_i) { 100_00 }
    let(:qc_e) { 200_00 }

    it "calculates no taxes owing" do
      expect(qc_y).to be_zero
    end
  end

  [
    [100_00, 0.14],
    [50_000_00, 0.19],
    [100_000_00, 0.24],
    [250_000_00, 0.2575]
  ].each do |values|
    it "selects #{values[1]} bracket for #{values[0]} income" do
      expect(described_class.new(**params.merge(qc_i: values[0])).qc_t.to_f).to eq(values[1])
    end
  end
end
