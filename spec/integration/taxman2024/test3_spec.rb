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
      taxable_periodic_income: 4_050,
      taxable_non_periodic_income: 0,
      rsp_deductions: 50,
      province: "mb"
    )
  end

  let(:y) do
    Taxman2024::YearInput.new(
      ytd_bonus: 0,
      pay_periods: 24,
      f5b_ytd: 0,
      employer_ei_multiple: 1.4
    )
  end

  let(:t) do
    Taxman2024::PersonalTaxDeductionsInput.new(
      federal_personal_amount: 15_705,
      provincial_personal_amount: 15_780
    )
  end

  let(:c) do
    Taxman2024::PensionInput.new(
      pensionable_income_this_period: 4_050,
      ytd_cpp_contributions: 1_375.94,
      ytd_qpp_contributions: 0,
      contribution_months_this_year: 12,
      ytd_pensionable_income: 23_125.04,
      ytd_additional_cpp_contributions: 0,
      ytd_additional_qpp_contributions: 0
    )
  end

  let(:e) do
    Taxman2024::EiInput.new(
      insurable_income_this_period: 4_000,
      employees_ytd_contributions: 391.20
    )
  end

  it "matches PDOC's federal tax" do
    expect(calculate[:federal_tax]).to eq 550.18
  end

  it "matches PDOC's provincial tax" do
    expect(calculate[:provincial_tax]).to eq 376.60
  end

  it "matches PDOC's CPP deduction" do
    expect(calculate[:employee_cpp_contribution]).to eq 232.30
  end

  it "matches PDOC's CPP2 deduction" do
    expect(calculate[:employee_cpp2_contribution]).to eq 0
  end

  it "matches PDOC's EI calculation" do
    expect(calculate[:employee_ei_contribution]).to eq 66.40
  end
end
