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
      taxable_periodic_income: 4_300,
      taxable_non_periodic_income: 2_000,
      qc_taxable_periodic_income: 4_300,
      qc_taxable_non_periodic_income: 2_000,
      province: "QC",
      periods_remaining_including_this_one: 15,
      moved_in_or_out_qc: true
    )
  end

  let(:y) do
    Taxman2024::YearInput.new(
      ytd_bonus: 5_000,
      pay_periods: 24,
      f5b_ytd: 0,
      ytd_gross_earnings: 41_000,
      ytd_csb: 62.15
    )
  end

  let(:t) do
    Taxman2024::PersonalTaxDeductionsInput.new(
      federal_personal_amount: 15_705,
      provincial_personal_amount: nil,
      tp_1015_line_7_indexed_value_of_personal_tax_credits: 18_056,
      tp_1015_line_9_non_indexed_value_of_personal_tax_credits: 200,
      tp_1015_line_11_additional_source_deductions: 50,
      tp_1015_line_19_deductions: 2_000
    )
  end

  let(:c) do
    Taxman2024::PensionInput.new(
      pensionable_income_this_period: 6_300,
      pensionable_non_periodic_income_this_period: 2_000,
      qc_pensionable_income_this_period: 6_300,
      qc_pensionable_non_periodic_income_this_period: 2_000,
      ytd_cpp_contributions: 229.32,
      ytd_qpp_contributions: 2_293.33,
      contribution_months_this_year: 12,
      ytd_pensionable_income: 41_000,
      ytd_additional_cpp_contributions: 0,
      ytd_additional_qpp_contributions: 0
    )
  end

  let(:q) do
    Taxman2024::QpipInput.new(
      parental_insurable_income_this_period: 6_000,
      ytd_employee_contributions: 202.54,
      ytd_employer_contributions: 0
    )
  end

  let(:e) do
    Taxman2024::EiInput.new(
      insurable_income_this_period: 6_000,
      insurable_non_periodic_income_this_period: 2_000,
      employees_ytd_contributions: 541.20
    )
  end

  it "matches PDOC's federal tax" do
    expect(calculate[:federal_tax]).to be_within(0.01).of 507.51
  end

  it "matches PDOC's federal tax on bonus" do
    expect(calculate[:federal_tax_on_bonus]).to be_within(0.01).of 339
  end

  it "matches WEBRAS's provincial tax" do
    expect(calculate[:provincial_tax]).to eq 608.39
  end

  it "matches WEBRAS's provincial bonus tax" do
    expect(calculate[:provincial_tax_on_bonus]).to eq 475.31
  end

  it "matches WEBRAS's QPP deduction" do
    expect(calculate[:employee_qpp_contribution]).to be_within(0.01).of 393.87
  end

  it "matches WEBRAS's QPP2 deduction" do
    expect(calculate[:employee_qpp2_contribution]).to eq 0
  end

  it "matches WEBRAS's QPIP employee deduction" do
    expect(calculate[:employee_qpip_contribution]).to eq 29.64
  end

  it "matches WEBRAS's QPIP employer deduction" do
    expect(calculate[:employer_qpip_contribution]).to eq 41.52
  end

  it "matches PDOC's EI calculation" do
    expect(calculate[:employee_ei_contribution]).to eq 79.20
  end
end
