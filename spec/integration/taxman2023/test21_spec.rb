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
      taxable_periodic_income: 1,
      taxable_non_periodic_income: 4_500,
      province: "ab"
    )
  end

  let(:y) do
    Taxman2023::YearInput.new(
      ytd_bonus: 0,
      pay_periods: 12,
      f5b_ytd: 0,
      employer_ei_multiple: 1.4
    )
  end

  let(:t) do
    Taxman2023::PersonalTaxDeductionsInput.new(
      federal_personal_amount: 15_000.00,
      provincial_personal_amount: 21_003.00,
      additional_tax_deductions: 0
    )
  end

  let(:c) do
    Taxman2023::PensionInput.new(
      pensionable_income_this_period: 4_501,
      pensionable_non_periodic_income_this_period: 4_500,
      ytd_cpp_contributions: 0,
      ytd_qpp_contributions: 0,
      contribution_months_this_year: 12
    )
  end

  let(:e) do
    Taxman2023::EiInput.new(
      insurable_income_this_period: 4_501,
      employees_ytd_contributions: 0
    )
  end

  it "matches PDOC's federal tax" do
    expect(calculate[:federal_tax]).to eq 0
  end

  it "matches PDOC's provincial tax" do
    expect(calculate[:provincial_tax]).to be_within(0.1).of 0
  end

  it "matches PDOC's federal tax on bonus" do
    expect(calculate[:federal_tax_on_bonus]).to be_within(0.1).of 450.00
  end

  it "matches PDOC's provincial tax on bonus" do
    expect(calculate[:provincial_tax_on_bonus]).to be_within(0.1).of 225.00
  end

  it "matches PDOC's CPP deduction" do
    expect(calculate[:employee_cpp_contribution]).to eq 267.75
  end

  it "matches PDOC's EI calculation" do
    expect(calculate[:employee_ei_contribution]).to eq 73.37
  end
end
