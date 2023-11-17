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
      taxable_periodic_income: 3_120,
      taxable_non_periodic_income: 3_500,
      province: "sk"
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
      federal_personal_amount: 15_000.00,
      provincial_personal_amount: 17_661.00,
      additional_tax_deductions: 0
    )
  end

  let(:c) do
    Taxman2024::PensionInput.new(
      pensionable_income_this_period: 6_620,
      pensionable_non_periodic_income_this_period: 3_500,
      ytd_cpp_contributions: 2_207.70,
      ytd_qpp_contributions: 0,
      contribution_months_this_year: 12
    )
  end

  let(:e) do
    Taxman2024::EiInput.new(
      insurable_income_this_period: 6_620,
      employees_ytd_contributions: 635.70
    )
  end

  it "matches PDOC's federal tax" do
    expect(calculate[:federal_tax]).to eq 382.97
  end

  it "matches PDOC's provincial tax" do
    expect(calculate[:provincial_tax]).to eq 249.45
  end

  it "matches PDOC's federal tax on bonus" do
    expect(calculate[:federal_tax_on_bonus]).to be_within(0.1).of 710.48
  end

  it "matches PDOC's provincial tax on bonus" do
    expect(calculate[:provincial_tax_on_bonus]).to be_within(0.1).of 433.22
  end

  it "matches PDOC's CPP deduction" do
    expect(calculate[:employee_cpp_contribution]).to eq 385.21
  end

  it "matches PDOC's EI calculation" do
    expect(calculate[:employee_ei_contribution]).to eq 107.91
  end
end
