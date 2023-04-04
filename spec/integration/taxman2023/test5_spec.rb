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
      taxable_periodic_income: 6_000,
      taxable_non_periodic_income: 0,
      province: "nl",
      union_dues: 30
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

  let(:t) { Taxman2023::Td1Input.new(federal_personal_amount: 15_000, provincial_personal_amount: 10_382) }

  let(:c) do
    Taxman2023::CppInput.new(
      pensionable_income_this_period: 6_000,
      ytd_contributions: 3_754.45,
      contribution_months_this_year: 12
    )
  end

  let(:e) do
    Taxman2023::EiInput.new(
      insurable_income_this_period: 6_000,
      employees_ytd_contributions: 1_002.45
    )
  end

  it "matches PDOC's federal tax" do
    expect(calculate[:federal_tax]).to eq 1_464.94
  end

  it "matches PDOC's provincial tax" do
    expect(calculate[:provincial_tax]).to eq 962.97
  end

  it "matches PDOC's CPP deduction" do
    expect(calculate[:employee_cpp_contribution]).to eq 0
  end

  it "matches PDOC's EI calculation" do
    expect(calculate[:employee_ei_contribution]).to eq 0
  end
end
# rubocop:enable RSpec/FilePath, RSpec/MultipleMemoizedHelpers
