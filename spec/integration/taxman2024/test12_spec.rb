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
      # The taxable_periodic_income in a sum of:
      #   salary or wages income:       13,000.00
      #   taxable benefit paid in cash:    500.00
      #   taxable benefits (non-cash):   1,000.00
      taxable_periodic_income: 14_500,
      taxable_non_periodic_income: 0,
      province: "yt"
    )
  end

  let(:y) do
    Taxman2024::YearInput.new(
      ytd_bonus: 0,
      pay_periods: 12,
      f5b_ytd: 0,
      employer_ei_multiple: 1.4
    )
  end

  let(:t) do
    Taxman2024::PersonalTaxDeductionsInput.new(
      federal_personal_amount: 14_388.47,
      provincial_personal_amount: 15_705,
      additional_tax_deductions: 0
    )
  end

  let(:c) do
    Taxman2024::PensionInput.new(
      pensionable_income_this_period: 14_500,
      ytd_cpp_contributions: 3_867.50,
      ytd_qpp_contributions: 0,
      contribution_months_this_year: 9,
      ytd_pensionable_income: 73_200.00,
      ytd_additional_cpp_contributions: 188,
      ytd_additional_qpp_contributions: 0
    )
  end

  let(:e) do
    Taxman2024::EiInput.new(
      insurable_income_this_period: 14_500,
      employees_ytd_contributions: 1_049.12
    )
  end

  it "matches PDOC's federal tax" do
    expect(calculate[:federal_tax]).to eq 2_752.73
  end

  it "matches PDOC's provincial tax" do
    expect(calculate[:provincial_tax]).to eq 1_169.68
  end

  it "matches PDOC's CPP deduction" do
    expect(calculate[:employee_cpp_contribution]).to eq 0
  end

  it "matches PDOC's EI calculation" do
    expect(calculate[:employee_ei_contribution]).to eq 0
  end
end
