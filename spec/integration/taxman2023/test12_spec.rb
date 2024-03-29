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
    Taxman2023::YearInput.new(
      ytd_bonus: 0,
      pay_periods: 12,
      f5b_ytd: 0,
      employer_ei_multiple: 1.4
    )
  end

  let(:t) do
    Taxman2023::PersonalTaxDeductionsInput.new(
      federal_personal_amount: 14_388.47,
      provincial_personal_amount: 15_000.00,
      additional_tax_deductions: 0
    )
  end

  let(:c) do
    Taxman2023::PensionInput.new(
      pensionable_income_this_period: 14_500,
      ytd_cpp_contributions: 3_754.45,
      ytd_qpp_contributions: 0,
      contribution_months_this_year: 9
    )
  end

  let(:e) do
    Taxman2023::EiInput.new(
      insurable_income_this_period: 14_500,
      employees_ytd_contributions: 1_002.45
    )
  end

  it "matches PDOC's federal tax" do
    expect(calculate[:federal_tax]).to eq 2_809.22
  end

  it "matches PDOC's provincial tax" do
    expect(calculate[:provincial_tax]).to eq 1_200.20
  end

  it "matches PDOC's CPP deduction" do
    expect(calculate[:employee_cpp_contribution]).to eq 0
  end

  it "matches PDOC's EI calculation" do
    expect(calculate[:employee_ei_contribution]).to eq 0
  end
end
