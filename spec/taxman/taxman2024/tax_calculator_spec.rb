# frozen_string_literal: true

RSpec.describe Taxman2024::TaxCalculator do
  let(:i) { 3_000_00.to_d }
  let(:b) { 5_000_00.to_d }
  let(:b1) { 1_000_00.to_d }
  let(:d) { 0 } # YTD CPP contribution
  let(:d1) { 0 } # YTD EI contribution
  let(:partial_context) { on_partial_context }
  let(:on_partial_context) do
    {
      p: 52,
      pi_periodic: i,
      ie_periodic: i,
      i: i,
      f: 0,
      f2: 0,
      f5a: 29_74.79.to_d,
      u1: 0,
      hd: 0,
      f1: 0,
      b: b,
      f3: 0,
      f5b: 49_57.98.to_d,
      b1: b1,
      f4: 0,
      f5b_ytd: 9_63.to_d,
      c: 472_00.to_d,
      province: "ON",
      k3: 0, # Other authorized per period federal deductions
      k3p: 0, # Other authorized per period provincial deductions
      l: 0,
      pi: i + b,
      ie: i + b,
      b_pensionable: b,
      b1_pensionable: b1,
      b_insurable: b,
      b1_insurable: b1,
      d: d,
      d1: d1,
      moved_in_or_out_qc: false,
      pm: 0,
      ei: 0,
      dq: 0,
      qc_a5: 0,
      qc_a6: 0
    }
  end
  let(:context) do
    {
      a: Taxman2024::A.new(**partial_context.slice(*Taxman2024::A.params)).amount
    }.merge(partial_context)
  end

  let(:tax) { described_class.new(context: context).calculate }

  it "matches the federal taxes on PDOC/Greg's sheet" do
    expect(tax[:federal_tax]).to be_within(0.1).of 533.25.to_d
  end

  it "matches the provincial taxes on PDOC/Greg's sheet" do
    expect(tax[:provincial_tax]).to be_within(0.1).of 311.74.to_d
  end

  context "when a required parameter is missing" do
    let(:tax) { described_class.new(context: partial_context).calculate }

    it "raises an error" do
      expect { tax }.to raise_error Taxman::ContextMissing
    end
  end

  it "matches the expected T3 amount" do
    expect(tax[:t3]).to be_within(0.1).of 27_729_11.53.to_d
  end

  context "when previously in Quebec" do
    let(:partial_context) do
      on_partial_context.merge(moved_in_or_out_qc: true)
    end

    it "matches the expected T3 amount" do
      expect(tax[:t3]).to be_within(0.1).of 28_369_10.83.to_d
    end
  end

  context "with quebec params" do
    let(:i) { 5_000_00.to_d }
    let(:b) { 20_000_00.to_d }
    let(:b1) { 0.to_d }
    let(:d) { 0 } # YTD CPP contribution
    let(:d1) { 0 } # YTD EI contribution
    let(:partial_context) { qc_partial_context }
    let(:qc_partial_context) do
      {
        p: 12,
        pi_periodic: i,
        ie_periodic: i,
        i: i,
        f: 0,
        f2: 0,
        f5a: 49_41.67.to_d,
        u1: 0,
        hd: 0,
        f1: 0,
        b: b,
        f3: 0,
        f5b: 49_57.98.to_d,
        b1: b1,
        f4: 0,
        f5b_ytd: 197_67.to_d,
        c: 0.to_d,
        k3: 0, # Other authorized per period federal deductions
        k3p: 0, # Other authorized per period provincial deductions
        l: 0,
        pi: i + b,
        ie: i + b,
        b_pensionable: 0,
        b1_pensionable: b1,
        b_insurable: 0,
        b1_insurable: b1,
        d: d,
        d1: d1,
        moved_in_or_out_qc: false,
        pm: 12,
        ei: 0,
        dq: 0,
        qc_g: 5_000_00.to_d,
        qc_d: 5_000_00.to_d,
        province: "QC",
        qc_c: 158_133.to_d,
        qc_c2: 0,
        qc_s3: 25_000.to_d,
        qc_b2: 20_000.to_d,
        qc_j: 0,
        qc_j1: 0,
        qc_k1: 0,
        qc_e1: 17_183_00.to_d,
        qc_e2: 0,
        qc_q: 0,
        qc_q1: 0,
        qc_l: 0,
        qc_a5: 0,
        qc_a6: 0
      }
    end

    it "matches the expected provincial taxes" do
      expect(tax[:provincial_tax]).to be_within(0.1).of 502.54.to_d
    end

    it "matches the expected T3 amount" do
      expect(tax[:t3]).to be_within(0.1).of 5_913_82.50.to_d
    end
  end
end
