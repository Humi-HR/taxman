# frozen_string_literal: true

# rubocop:disable RSpec/FilePath
RSpec.describe Taxman2023::Calculate do
  let(:calculate) do
    described_class.new(
      period_input: p,
      year_input: y,
      td1_input: t,
      cpp_input: c,
      ei_input: e
    ).call
  end

  let(:p) do
    Taxman2023::PeriodInput.new(
      taxable_periodic_income: 600,
      taxable_non_periodic_income: 600.00,
      province: "on"
    )
  end

  let(:y) do
    Taxman2023::YearInput.new(
      ytd_bonus: 0,
      pay_periods: 26,
      f5b_ytd: 0,
      employer_ei_multiple: 1.4
    )
  end

  let(:t) do
    Taxman2023::Td1Input.new(
      federal_personal_amount: 15_000.00,
      provincial_personal_amount: 11_865.00,
      additional_tax_deductions: 0
    )
  end

  let(:c) do
    Taxman2023::CppInput.new(
      pensionable_income_this_period: 1_200,
      pensionable_non_periodic_income_this_period: 600,
      ytd_contributions: 332.28,
      contribution_months_this_year: 12
    )
  end

  let(:e) do
    Taxman2023::EiInput.new(
      insurable_income_this_period: 1_200,
      employees_ytd_contributions: 117.36
    )
  end

  it "matches PDOC's federal tax" do
    expect(calculate[:federal_tax]).to eq 0
  end

  it "matches PDOC's provincial tax" do
    expect(calculate[:provincial_tax]).to eq 0
  end

  it "matches PDOC's federal tax on bonus" do
    expect(calculate[:federal_tax_on_bonus]).to be_within(0.1).of 0
  end

  it "matches PDOC's provincial tax on bonus" do
    expect(calculate[:provincial_tax_on_bonus]).to be_within(0.1).of 0
  end

  it "matches PDOC's CPP deduction" do
    expect(calculate[:employee_cpp_contribution]).to eq 63.39
  end

  it "matches PDOC's EI calculation" do
    expect(calculate[:employee_ei_contribution]).to eq 19.56
  end
end
# rubocop:enable RSpec/FilePath, RSpec/MultipleMemoizedHelpers
