# frozen_string_literal: true

# rubocop:disable RSpec/FilePath
RSpec.describe Taxman2023::Calculate do
  let(:calculate) do
    described_class.new(
      period_input: p,
      year_input: y,
      td1_input: t,
      pension_input: c,
      ei_input: e
    ).call
  end

  let(:p) do
    Taxman2023::PeriodInput.new(
      taxable_periodic_income: 2_080,
      taxable_non_periodic_income: 0,
      province: "ab"
    )
  end

  let(:y) do
    Taxman2023::YearInput.new(
      ytd_bonus: 0,
      pay_periods: 52,
      f5b_ytd: 0,
      employer_ei_multiple: 1.4
    )
  end

  let(:t) { Taxman2023::Td1Input.new(federal_personal_amount: 15_000, provincial_personal_amount: 21_003) }

  let(:c) do
    Taxman2023::PensionInput.new(
      pensionable_income_this_period: 2_080,
      ytd_cpp_contributions: 0,
      ytd_qpp_contributions: 0,
      contribution_months_this_year: 12
    )
  end

  let(:e) do
    Taxman2023::EiInput.new(
      insurable_income_this_period: 2_080,
      employees_ytd_contributions: 0
    )
  end

  it "matches PDOC's federal tax" do
    expect(calculate[:federal_tax]).to eq 307.14
  end

  it "matches PDOC's provincial tax" do
    expect(calculate[:provincial_tax]).to eq 157.66
  end

  it "matches PDOC's CPP deduction" do
    expect(calculate[:employee_cpp_contribution]).to eq 119.76
  end

  it "matches PDOC's EI calculation" do
    expect(calculate[:employee_ei_contribution]).to eq 33.90
  end
end
# rubocop:enable RSpec/FilePath, RSpec/MultipleMemoizedHelpers
