# frozen_string_literal: true

RSpec.describe Taxman2023::PersonalTaxDeductionsInput do
  let(:deductions_input) do
    described_class.new(
      federal_personal_amount: tc,
      provincial_personal_amount: tcp,
      federal_personal_amount_offset: tc_offset,
      provincial_personal_amount_offset: tcp_offset,
      deduction_for_zone: hd,
      additional_tax_deductions: l
    )
  end

  context "with inputs" do
    let(:tc) { 15_000 }
    let(:tcp) { 12_000 }
    let(:tc_offset) { 1 }
    let(:tcp_offset) { 2 }
    let(:hd) { 4 }
    let(:l) { 5 }

    it "translates the inputs" do
      expect(deductions_input.translate).to eq(
        {
          tc: 15_000_00.to_d,
          tcp: 12_000_00.to_d,
          tc_offset: 1_00.to_d,
          tcp_offset: 2_00.to_d,
          hd: 4_00.to_d,
          l: 5_00.to_d,
          qc_e1: 17_183_00.to_d,
          qc_e2: 0.to_d,
          qc_j: 0.to_d,
          qc_j1: 0.to_d,
          qc_k1: 0.to_d,
          qc_k2: 0.to_d,
          qc_l: 0.to_d,
          qc_q: 0.to_d,
          qc_q1: 0.to_d
        }
      )
    end
  end

  context "with no params" do
    let(:deductions_input) { described_class.new }

    it "has default values" do
      expect(deductions_input.translate).to eq(
        {
          tc: nil,
          tcp: nil,
          tc_offset: 0,
          tcp_offset: 0,
          hd: 0,
          l: 0,
          qc_e1: 17_183_00.to_d,
          qc_e2: 0.to_d,
          qc_j: 0.to_d,
          qc_j1: 0.to_d,
          qc_k1: 0.to_d,
          qc_k2: 0.to_d,
          qc_l: 0.to_d,
          qc_q: 0.to_d,
          qc_q1: 0.to_d
        }
      )
    end
  end
end
