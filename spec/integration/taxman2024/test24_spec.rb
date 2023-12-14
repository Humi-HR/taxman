# frozen_string_literal: true

RSpec.describe Taxman2024::Calculate do
  let(:calculate) do
    described_class.new(
      period_input: p,
      year_input: y,
      personal_tax_input: t,
      pension_input: c,
      ei_input: e
    ).call
  end

  let(:p) do
    Taxman2024::PeriodInput.new(
      taxable_periodic_income: 1_696.00,
      taxable_non_periodic_income: 0,
      province: "mb"
    )
  end

  let(:y) do
    Taxman2024::YearInput.new(
      ytd_bonus: 66_450.00,
      ytd_pensionable_bonus: 66_450.00,
      ytd_insurable_bonus: 66_450.00,
      pay_periods: 26,
      f5b_ytd: 493.06204321434527462766323475318232444487,
      employer_ei_multiple: 1.4
    )
  end

  let(:t) do
    Taxman2024::PersonalTaxDeductionsInput.new(
      federal_personal_amount: 15_705,
      provincial_personal_amount: 15_780,
      additional_tax_deductions: 0
    )
  end

  let(:c) do
    Taxman2024::PensionInput.new(
      pensionable_income_this_period: 1_696.00,
      pensionable_non_periodic_income_this_period: 0,
      ytd_cpp_contributions: 1_003.15,
      ytd_qpp_contributions: 0,
      contribution_months_this_year: 12,
      ytd_pensionable_income: 17_600.00,
      ytd_additional_cpp_contributions: 0,
      ytd_additional_qpp_contributions: 0
    )
  end

  let(:e) do
    Taxman2024::EiInput.new(
      insurable_income_this_period: 1_696.00,
      employees_ytd_contributions: 292.16
    )
  end

  it "matches PDOC's federal tax" do
    expect(calculate[:federal_tax]).to eq 137.37
  end

  it "matches PDOC's provincial tax" do
    expect(calculate[:provincial_tax]).to be_within(0.1).of 104.55
  end

  it "matches PDOC's CPP deduction" do
    expect(calculate[:employee_cpp_contribution]).to be_within(0.1).of 92.90
  end

  it "matches PDOC's CPP2 deduction" do
    expect(calculate[:employee_cpp2_contribution]).to eq 0
  end

  it "matches PDOC's EI calculation" do
    expect(calculate[:employee_ei_contribution]).to eq 28.15
  end
end
