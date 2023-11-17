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
      taxable_periodic_income: 400,
      taxable_non_periodic_income: 2_500,
      province: "nl"
    )
  end

  let(:y) do
    Taxman2024::YearInput.new(
      ytd_bonus: 2_500,
      pay_periods: 12,
      f5b_ytd: 9.75,
      employer_ei_multiple: 1.4
    )
  end

  let(:t) do
    Taxman2024::PersonalTaxDeductionsInput.new(
      federal_personal_amount: 15_000.00,
      provincial_personal_amount: 10_382.00,
      additional_tax_deductions: 0
    )
  end

  let(:c) do
    Taxman2024::PensionInput.new(
      pensionable_income_this_period: 2_900,
      pensionable_non_periodic_income_this_period: 2_500,
      ytd_cpp_contributions: 19.34,
      ytd_qpp_contributions: 0,
      contribution_months_this_year: 9
    )
  end

  let(:e) do
    Taxman2024::EiInput.new(
      insurable_income_this_period: 2_900,
      employees_ytd_contributions: 19.56
    )
  end

  it "matches PDOC's federal tax" do
    expect(calculate[:federal_tax]).to eq 0
  end

  it "matches PDOC's provincial tax" do
    expect(calculate[:provincial_tax]).to eq 0
  end

  it "matches PDOC's federal tax on bonus" do
    expect(calculate[:federal_tax_on_bonus]).to eq 0.0
  end

  it "matches PDOC's provincial tax on bonus" do
    expect(calculate[:provincial_tax_on_bonus]).to eq 0.0
  end

  it "matches PDOC's CPP deduction" do
    expect(calculate[:employee_cpp_contribution]).to eq 155.20
  end

  it "matches PDOC's EI calculation" do
    expect(calculate[:employee_ei_contribution]).to eq 47.27
  end
end
