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
      taxable_periodic_income: 5_000,
      taxable_non_periodic_income: 0,
      rsp_deductions: 400,
      province: "nb"
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
      federal_personal_amount: 15_000,
      provincial_personal_amount: 12_458
    )
  end

  let(:c) do
    Taxman2023::PensionInput.new(
      pensionable_income_this_period: 5_000,
      ytd_cpp_contributions: 1_120.58,
      ytd_qpp_contributions: 0,
      contribution_months_this_year: 12
    )
  end

  let(:e) do
    Taxman2023::EiInput.new(
      insurable_income_this_period: 5_000,
      employees_ytd_contributions: 326
    )
  end

  it "matches PDOC's federal tax" do
    expect(calculate[:federal_tax]).to eq 436.98
  end

  it "matches PDOC's provincial tax" do
    expect(calculate[:provincial_tax]).to eq 327.34
  end

  it "matches PDOC's CPP deduction" do
    expect(calculate[:employee_cpp_contribution]).to eq 280.15
  end

  it "matches PDOC's EI calculation" do
    expect(calculate[:employee_ei_contribution]).to eq 81.50
  end
end
