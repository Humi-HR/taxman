# frozen_string_literal: true

# rubocop:disable RSpec/FilePath
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
      taxable_periodic_income: 3_125,
      taxable_non_periodic_income: 6_250,
      province: "on"
    )
  end

  let(:y) do
    Taxman2023::YearInput.new(
      ytd_bonus: 0,
      pay_periods: 24,
      f5b_ytd: 0,
      employer_ei_multiple: 1.4
    )
  end

  let(:t) do
    Taxman2023::PersonalTaxDeductionsInput.new(
      federal_personal_amount: 15_000,
      provincial_personal_amount: 11_865
    )
  end

  let(:c) do
    Taxman2023::PensionInput.new(
      pensionable_income_this_period: 9_375,
      ytd_cpp_contributions: 0,
      ytd_qpp_contributions: 0,
      contribution_months_this_year: 12
    )
  end

  let(:e) do
    Taxman2023::EiInput.new(
      insurable_income_this_period: 9_375,
      employees_ytd_contributions: 0
    )
  end

  it "matches PDOC's federal tax" do
    expect(calculate[:federal_tax]).to eq 383.94
  end

  it "matches PDOC's provincial tax" do
    expect(calculate[:provincial_tax]).to eq 196.64
  end

  it "matches PDOC's CPP deduction" do
    expect(calculate[:employee_cpp_contribution]).to eq 549.14
  end

  it "matches PDOC's EI calculation" do
    expect(calculate[:employee_ei_contribution]).to be_within(0.1).of 152.82
  end

  it "matches PDOC's federal bonux tax" do
    expect(calculate[:federal_tax_on_bonus]).to eq 1_268.64
  end

  it "matches PDOC's provincial bonus tax" do
    expect(calculate[:provincial_tax_on_bonus]).to eq 566.25
  end
end
# rubocop:enable RSpec/FilePath
