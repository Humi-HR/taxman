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
      taxable_periodic_income: 2_400,
      taxable_non_periodic_income: 0,
      province: "on"
    )
  end

  let(:y) do
    Taxman2024::YearInput.new(
      ytd_bonus: 0,
      pay_periods: 26,
      f5b_ytd: 0,
      employer_ei_multiple: 1.4
    )
  end

  let(:t) do
    Taxman2024::PersonalTaxDeductionsInput.new(
      federal_personal_amount: 15_705,
      provincial_personal_amount: 12_399,
      additional_tax_deductions: 150
    )
  end

  let(:c) do
    Taxman2024::PensionInput.new(
      pensionable_income_this_period: 2_400,
      ytd_cpp_contributions: 332.97,
      ytd_qpp_contributions: 0,
      contribution_months_this_year: 12,
      ytd_pensionable_income: 5_596.14,
      ytd_additional_cpp_contributions: 0,
      ytd_additional_qpp_contributions: 0
    )
  end

  let(:e) do
    Taxman2024::EiInput.new(
      insurable_income_this_period: 2_400,
      employees_ytd_contributions: 97.80
    )
  end

  it "matches PDOC's federal tax" do
    expect(calculate[:federal_tax]).to be_within(0.01).of 247.50
  end

  it "matches PDOC's provincial tax" do
    expect(calculate[:provincial_tax]).to eq 127.73
  end

  it "matches PDOC's additional tax" do
    expect(calculate[:additional_tax]).to eq 150
  end

  it "matches PDOC's total tax" do
    expect(calculate[:total_tax]).to eq 525.23
  end

  it "matches PDOC's CPP deduction" do
    expect(calculate[:employee_cpp_contribution]).to eq 134.79
  end

  it "matches PDOC's CPP2 deduction" do
    expect(calculate[:employee_cpp2_contribution]).to eq 0
  end

  it "matches PDOC's EI calculation" do
    expect(calculate[:employee_ei_contribution]).to eq 39.84
  end
end
