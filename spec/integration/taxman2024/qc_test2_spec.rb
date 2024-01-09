# frozen_string_literal: true

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
      rsp_deductions: 50,
      taxable_non_periodic_income: 500,
      taxable_periodic_income: 1000,
      qc_taxable_non_periodic_income: 500,
      qc_taxable_periodic_income: 1000,
      province: "QC",
      periods_remaining_including_this_one: 6
    )
  end

  let(:y) do
    Taxman2024::YearInput.new(
      ytd_bonus: 1500,
      pay_periods: 26,
      f5b_ytd: 0,
      ytd_gross_earnings: 21_500,
      ytd_deductions_for_employment_income: 200,
      ytd_csb: 62.15
    )
  end

  let(:t) do
    Taxman2024::PersonalTaxDeductionsInput.new
  end

  let(:c) do
    Taxman2024::PensionInput.new(
      pensionable_income_this_period: 1500,
      pensionable_non_periodic_income_this_period: 500,
      qc_pensionable_income_this_period: 1500,
      qc_pensionable_non_periodic_income_this_period: 500,
      ytd_cpp_contributions: 0,
      ytd_qpp_contributions: 1_203.69,
      contribution_months_this_year: 10,
      ytd_pensionable_income: 0,
      ytd_additional_cpp_contributions: 0,
      ytd_additional_qpp_contributions: 0
    )
  end

  let(:q) do
    Taxman2024::QpipInput.new(
      parental_insurable_income_this_period: 1500,
      ytd_employee_contributions: 106.21
    )
  end

  let(:e) do
    Taxman2024::EiInput.new(
      insurable_income_this_period: 1500,
      insurable_non_periodic_income_this_period: 500,
      employees_ytd_contributions: 0
    )
  end

  it "matches PDOC's federal tax" do
    expect(calculate[:federal_tax]).to be_within(0.1).of 30.94
  end

  it "matches PDOC's federal tax on bonus" do
    expect(calculate[:federal_tax_on_bonus]).to be_within(0.1).of 57.57
  end

  it "matches WEBRAS's provincial tax" do
    expect(calculate[:provincial_tax]).to eq 32.12
  end

  it "matches WEBRAS's provincial bonus tax" do
    expect(calculate[:provincial_tax_on_bonus]).to eq 69.36
  end

  it "matches WEBRAS's QPP deduction" do
    expect(calculate[:employee_qpp_contribution]).to eq 87.38
  end

  it "matches WEBRAS's QPIP employee deduction" do
    expect(calculate[:employee_qpip_contribution]).to eq 7.41
  end

  it "matches WEBRAS's QPIP employer deduction" do
    expect(calculate[:employer_qpip_contribution]).to eq 10.38
  end

  it "matches PDOC's EI calculation" do
    expect(calculate[:employee_ei_contribution]).to eq 19.05
  end
end
