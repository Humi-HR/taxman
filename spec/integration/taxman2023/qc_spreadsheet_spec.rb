# frozen_string_literal: true

# Tests in this spec comes from the Quebec implementation spreadsheet

RSpec.describe Taxman2023::Calculate do
  let(:calculate) do
    described_class.new(
      period_input: p,
      year_input: y,
      personal_tax_input: t,
      pension_input: c,
      qpip_input: q,
      ei_input: e
    ).call
  end

  let(:p) do
    Taxman2023::PeriodInput.new(
      taxable_periodic_income: 5_000,
      taxable_non_periodic_income: 20_000,
      province: "qc",
      periods_remaining_including_this_one: 12
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
      federal_personal_amount: nil,
      provincial_personal_amount: nil
    )
  end

  let(:c) do
    Taxman2023::PensionInput.new(
      pensionable_income_this_period: 25_000,
      pensionable_non_periodic_income_this_period: 20_000,
      ytd_cpp_contributions: 0,
      ytd_qpp_contributions: 0,
      contribution_months_this_year: 12
    )
  end

  let(:q) do
    Taxman2023::QpipInput.new(
      parental_insurable_income_this_period: 25_000,
      ytd_employee_contributions: 0,
      ytd_employer_contributions: 0
    )
  end

  let(:e) do
    Taxman2023::EiInput.new(
      insurable_income_this_period: 25_000,
      insurable_non_periodic_income_this_period: 20_000,
      employees_ytd_contributions: 0
    )
  end

  it "matches PDOC's federal tax" do
    expect(calculate[:federal_tax]).to be_within(0.1).of 429.44
  end

  it "matches PDOC's federal tax on bonus" do
    expect(calculate[:federal_tax_on_bonus]).to be_within(0.1).of 3_330.26
  end

  it "matches WEBRAS's provincial tax" do
    expect(calculate[:provincial_tax]).to eq 514.07
  end

  it "matches WEBRAS's provincial bonus tax" do
    expect(calculate[:provincial_tax_on_bonus]).to eq 3_762.44
  end

  it "matches WEBRAS's QPP deduction" do
    expect(calculate[:employee_qpp_contribution]).to eq 1581.33
  end

  it "matches WEBRAS's QPIP employee deduction" do
    expect(calculate[:employee_qpip_contribution]).to eq 123.5
  end

  it "matches WEBRAS's QPIP employer deduction" do
    expect(calculate[:employer_qpip_contribution]).to eq 173
  end

  it "matches PDOC's EI calculation" do
    expect(calculate[:employee_ei_contribution]).to eq 317.50
  end
end
