# frozen_string_literal: true

RSpec.describe Taxman2023::QcI1 do
  let(:qc_i1) do
    described_class
      .new(
        qc_g1: qc_g1,
        qc_f1: qc_f1,
        qc_h1: qc_h1,
        qc_csa1: qc_csa1,
        qc_pr: qc_pr,
        qc_g: qc_g,
        f: f,
        qc_h2: qc_h2,
        qc_csa: qc_csa,
        qc_j: qc_j,
        qc_j1: qc_j1
      )
      .amount
  end
  let(:qc_g1) { 0.0 }
  let(:qc_f1) { 0.0 }
  let(:qc_h1) { 0.0 }
  let(:qc_csa1) { 0.0 }
  let(:qc_pr) { 12.0 }
  let(:qc_g) { 5_000_00.0 }
  let(:f) { 0.0 }
  let(:qc_h2) { 109_58.0 }
  let(:qc_csa) { 49_41.6666667 }
  let(:qc_j) { 0.0 }
  let(:qc_j1) { 0.0 }

  it "matches implementation spreadsheet (sheet does strange rounding)" do
    expect(qc_i1.round).to eq 58_092_04
  end
end
