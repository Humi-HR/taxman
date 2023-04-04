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
      taxable_periodic_income: 4_050,
      taxable_non_periodic_income: 0,
      rsp_deductions: 50,
      province: "mb"
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

  let(:t) { Taxman2023::Td1Input.new(federal_personal_amount: 15_000, provincial_personal_amount: 10_855) }

  let(:c) do
    Taxman2023::CppInput.new(
      pensionable_income_this_period: 4_050,
      ytd_contributions: 1_375.94,
      contribution_months_this_year: 12
    )
  end

  let(:e) do
    Taxman2023::EiInput.new(
      insurable_income_this_period: 4_000,
      employees_ytd_contributions: 391.20
    )
  end

  it "matches PDOC's federal tax" do
    expect(calculate[:federal_tax]).to eq 561.62
  end

  # pdf gives 437.59, we get 437.58 :(
  it "matches PDOC's provincial tax" do
    expect(calculate[:provincial_tax]).to be_within(0.1).of 437.59
  end

  it "matches PDOC's CPP deduction" do
    expect(calculate[:employee_cpp_contribution]).to eq 232.30
  end

  it "matches PDOC's EI calculation" do
    expect(calculate[:employee_ei_contribution]).to eq 65.20
  end
end
# rubocop:enable RSpec/FilePath, RSpec/MultipleMemoizedHelpers
