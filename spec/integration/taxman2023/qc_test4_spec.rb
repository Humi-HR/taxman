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
      taxable_periodic_income: 10_000,
      taxable_non_periodic_income: 0,
      province: "qc",
      periods_remaining_including_this_one: 3
    )
  end

  let(:y) do
    Taxman2023::YearInput.new(
      ytd_bonus: 8_000,
      pay_periods: 12,
      f5b_ytd: 0,
      employer_ei_multiple: 1.4,
      ytd_gross_earnings: 90_000.00
    )
  end

  let(:t) do
    Taxman2023::PersonalTaxDeductionsInput.new(
      federal_personal_amount: nil,
      provincial_personal_amount: nil,
      tp_1015_line_7_indexed_value_of_personal_tax_credits: 25_000
    )
  end

  let(:c) do
    Taxman2023::PensionInput.new(
      pensionable_income_this_period: 10_000,
      ytd_cpp_contributions: 0,
      ytd_qpp_contributions: 4_038.40,
      contribution_months_this_year: 12
    )
  end

  let(:q) do
    Taxman2023::QpipInput.new(
      parental_insurable_income_this_period: 10_000,
      ytd_employee_contributions: 444.60,
      ytd_employer_contributions: 622.81
    )
  end

  let(:e) do
    Taxman2023::EiInput.new(
      insurable_income_this_period: 10_000,
      employees_ytd_contributions: 0
    )
  end

  it "matches PDOC's federal tax" do
    expect(calculate[:federal_tax]).to be_within(0.1).of 1339.14
  end

  it "matches PDOC's federal tax on bonus" do
    expect(calculate[:federal_tax_on_bonus]).to be_within(0.1).of 0
  end

  it "matches WEBRAS's provincial tax" do
    expect(calculate[:provincial_tax]).to eq 1466.20
  end

  it "matches WEBRAS's provincial bonus tax" do
    expect(calculate[:provincial_tax_on_bonus]).to eq 0
  end

  it "matches WEBRAS's QPP deduction" do
    expect(calculate[:employee_qpp_contribution]).to eq 0
  end

  it "matches WEBRAS's QPIP employee deduction" do
    expect(calculate[:employee_qpip_contribution]).to eq 4.94
  end

  it "matches WEBRAS's QPIP employer deduction" do
    # WEBRAS does not have an input for QPIP employer contrib, sooooo....
    expect(calculate[:employer_qpip_contribution]).to eq 6.92
  end

  it "matches PDOC's EI calculation" do
    expect(calculate[:employee_ei_contribution]).to eq 127.0
  end
end
