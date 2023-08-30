# frozen_string_literal: true

RSpec.describe Taxman2023::QcE do
  let(:qc_e) { described_class.amount(qc_e1: qc_e1, qc_e2: qc_e2) }
  let(:qc_e1) { 10.to_d }
  let(:qc_e2) { 20.to_d }

  it "adds" do
    expect(qc_e).to eq 30.to_d
  end

  context "with fractions" do
    let(:qc_e1) { 10.4.to_d }
    let(:qc_e2) { 20.1.to_d }

    it "rounds" do
      expect(qc_e).to eq 31.to_d
    end
  end
end
