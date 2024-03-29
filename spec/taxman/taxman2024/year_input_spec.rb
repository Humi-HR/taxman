# frozen_string_literal: true

RSpec.describe Taxman2024::YearInput do
  let(:year_input) do
    described_class.new(
      ytd_bonus: 1,
      ytd_rsp_bonus_deductions: 3, # F4
      pay_periods: 12,
      f5b_ytd: 4,
      employer_ei_multiple: 1.3,
      ytd_deductions_for_employment_income: 753,
      ytd_rsp_deductions: 111,
      ytd_gross_earnings: 222,
      ytd_csa: 333,
      ytd_csb: 555,
      ytd_insurable_earnings: 777
    )
  end

  it "translates the inputs" do
    expect(year_input.translate).to eq(
      {
        b1: 1_00.to_d,
        b1_insurable: 1_00.to_d,
        b1_pensionable: 1_00.to_d,
        f4: 3_00.to_d,
        p: 12,
        f5b_ytd: 4_00.to_d,
        employer_ei_multiple: 1.3.to_d,
        qc_b1: 1_00.to_d,
        qc_f1: 111_00.to_d,
        qc_g1: 222_00.to_d,
        qc_h1: 753_00.to_d,
        qc_csa1: 333_00.to_d,
        qc_csb1: 555_00.to_d,
        ie_ytd: 777_00.to_d
      }
    )
  end

  context "without optional params" do
    let(:year_input) { described_class.new(ytd_bonus: 1, f5b_ytd: 2, pay_periods: 26) }

    it "has default values" do
      expect(year_input.translate).to eq(
        {
          b1: 1_00.to_d,
          b1_pensionable: 1_00.to_d,
          b1_insurable: 1_00.to_d,
          f5b_ytd: 2_00.to_d,
          p: 26,
          f4: 0,
          employer_ei_multiple: 1.4.to_d,
          qc_b1: 1_00.to_d,
          qc_f1: 0,
          qc_g1: 0,
          qc_h1: 0,
          qc_csa1: 0,
          qc_csb1: 0,
          ie_ytd: 0
        }
      )
    end
  end
end
