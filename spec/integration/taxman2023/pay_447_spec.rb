# frozen_string_literal: true

RSpec.describe Taxman2023::Calculate do
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
    Taxman2023::PeriodInput.new(
      taxable_periodic_income: 2_400,
      taxable_non_periodic_income: 0,
      province: "on"
    )
  end

  let(:y) do
    Taxman2023::YearInput.new(
      ytd_bonus: 0,
      pay_periods: 26,
      f5b_ytd: 0,
      employer_ei_multiple: 1.4
    )
  end

  let(:t) do
    Taxman2023::PersonalTaxDeductionsInput.new(
      federal_personal_amount: 15_000,
      provincial_personal_amount: 11_865,
      additional_tax_deductions: 150
    )
  end

  let(:c) do
    Taxman2023::PensionInput.new(
      pensionable_income_this_period: 2_400,
      ytd_cpp_contributions: 332.97,
      ytd_qpp_contributions: 0,
      contribution_months_this_year: 12
    )
  end

  let(:e) do
    Taxman2023::EiInput.new(
      insurable_income_this_period: 2_400,
      employees_ytd_contributions: 97.80
    )
  end

  it "matches PDOC's federal tax" do
    expect(calculate[:federal_tax]).to eq 257.44
  end

  it "matches PDOC's provincial tax" do
    expect(calculate[:provincial_tax]).to eq 132.33
  end

  it "matches PDOC's additional tax" do
    expect(calculate[:additional_tax]).to eq 150
  end

  it "matches PDOC's total tax" do
    expect(calculate[:total_tax]).to eq 539.77
  end

  it "matches PDOC's CPP deduction" do
    expect(calculate[:employee_cpp_contribution]).to eq 134.79
  end

  it "matches PDOC's EI calculation" do
    expect(calculate[:employee_ei_contribution]).to eq 39.12
  end
end
