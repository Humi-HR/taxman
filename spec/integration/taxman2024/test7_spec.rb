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
      taxable_periodic_income: 8_000,
      taxable_non_periodic_income: 0,
      province: "on"
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
      provincial_personal_amount: 12_399,
      additional_tax_deductions: 0
    )
  end

  let(:c) do
    Taxman2024::PensionInput.new(
      pensionable_income_this_period: 8_000,
      ytd_cpp_contributions: 3_754.45,
      ytd_qpp_contributions: 0,
      contribution_months_this_year: 7,
      ytd_pensionable_income: 73_200.00,
      ytd_additional_cpp_contributions: 188,
      ytd_additional_qpp_contributions: 0
    )
  end

  let(:e) do
    Taxman2024::EiInput.new(
      insurable_income_this_period: 8_000,
      employees_ytd_contributions: 1_049.12
    )
  end

  it "matches PDOC's federal tax" do
    expect(calculate[:federal_tax]).to eq 1_585.64
  end

  it "matches PDOC's provincial tax" do
    expect(calculate[:provincial_tax]).to be_within(0.1).of 972.21
  end

  it "matches PDOC's CPP deduction" do
    expect(calculate[:employee_cpp_contribution]).to eq 0
  end

  it "matches PDOC's CPP2 deduction" do
    expect(calculate[:employee_cpp2_contribution]).to eq 0
  end

  it "matches PDOC's EI calculation" do
    expect(calculate[:employee_ei_contribution]).to eq 0
  end
end
