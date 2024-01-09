# frozen_string_literal: true

# Tests in this spec comes from the Quebec implementation spreadsheet

RSpec.describe Taxman2024::Calculate do
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
    Taxman2024::PeriodInput.new(
      taxable_periodic_income: 10_000,
      taxable_non_periodic_income: 1_000,
      qc_taxable_periodic_income: 10_000,
      qc_taxable_non_periodic_income: 1_000,
      province: "qc",
      periods_remaining_including_this_one: 48
    )
  end

  let(:y) do
    Taxman2024::YearInput.new(
      ytd_bonus: 8_000,
      pay_periods: 52,
      f5b_ytd: 0,
      employer_ei_multiple: 1.4,
      ytd_gross_earnings: 40_000.00,
      ytd_csb: 100.0
    )
  end

  let(:t) do
    Taxman2024::PersonalTaxDeductionsInput.new(
      federal_personal_amount: nil,
      provincial_personal_amount: nil,
      tp_1015_line_9_non_indexed_value_of_personal_tax_credits: 100
    )
  end

  let(:c) do
    Taxman2024::PensionInput.new(
      pensionable_income_this_period: 11_000,
      pensionable_non_periodic_income_this_period: 1_000,
      qc_pensionable_income_this_period: 11_000,
      qc_pensionable_non_periodic_income_this_period: 1_000,
      ytd_cpp_contributions: 0,
      ytd_qpp_contributions: 2_542.77,
      contribution_months_this_year: 12,
      ytd_pensionable_income: 0,
      ytd_additional_cpp_contributions: 0,
      ytd_additional_qpp_contributions: 0
    )
  end

  let(:q) do
    Taxman2024::QpipInput.new(
      parental_insurable_income_this_period: 11_000,
      ytd_employee_contributions: 197.60,
      ytd_employer_contributions: 0
    )
  end

  let(:e) do
    Taxman2024::EiInput.new(
      insurable_income_this_period: 11_000,
      insurable_non_periodic_income_this_period: 1_000,
      employees_ytd_contributions: 0
    )
  end

  it "matches PDOC's federal tax" do
    expect(calculate[:federal_tax]).to be_within(3.6).of 2_305.07
  end

  it "matches PDOC's federal tax on bonus" do
    expect(calculate[:federal_tax_on_bonus]).to be_within(0.1).of 272.81
  end

  it "matches WEBRAS's provincial tax" do
    # A quarter ish off...
    expect(calculate[:provincial_tax]).to be_within(0.28).of 2_314.15
  end

  it "matches WEBRAS's provincial bonus tax" do
    expect(calculate[:provincial_tax_on_bonus]).to eq 254.94
  end

  it "matches WEBRAS's QPP deduction" do
    expect(calculate[:employee_qpp_contribution]).to eq 699.69
  end

  it "matches WEBRAS's QPIP employee deduction" do
    expect(calculate[:employee_qpip_contribution]).to eq 54.34
  end

  it "matches WEBRAS's QPIP employer deduction" do
    expect(calculate[:employer_qpip_contribution]).to eq 76.12
  end

  it "matches PDOC's EI calculation" do
    expect(calculate[:employee_ei_contribution]).to eq 139.70
  end
end
