# frozen_string_literal: true

# rubocop:disable RSpec/FilePath, RSpec/MultipleMemoizedHelpers
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
      taxable_periodic_income: 300,
      taxable_non_periodic_income: 5000,
      union_dues: 50,
      province: "nb"
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
    Taxman2023::Td1Input.new(
      federal_personal_amount: 15_000.00,
      provincial_personal_amount: 12_458.00,
      additional_tax_deductions: 0
    )
  end

  let(:c) do
    Taxman2023::CppInput.new(
      pensionable_income_this_period: 5_300,
      ytd_contributions: 55.04,
      contribution_months_this_year: 12
    )
  end

  let(:e) do
    Taxman2023::EiInput.new(
      insurable_income_this_period: 5_300,
      employees_ytd_contributions: 29.34
    )
  end

  it "matches PDOC's federal tax" do
    expect(calculate[:federal_tax]).to eq 0
  end

  it "matches PDOC's provincial tax" do
    expect(calculate[:provincial_tax]).to eq 0
  end

  it "matches PDOC's federal tax on bonus" do
    expect(calculate[:federal_tax_on_bonus]).to eq 0.0
  end

  it "matches PDOC's provincial tax on bonus" do
    expect(calculate[:provincial_tax_on_bonus]).to eq 0.0
  end

  it "matches PDOC's CPP deduction" do
    expect(calculate[:employee_cpp_contribution]).to eq 306.67
  end

  it "matches PDOC's EI calculation" do
    expect(calculate[:employee_ei_contribution]).to eq 86.39
  end
end
# rubocop:enable RSpec/FilePath, RSpec/MultipleMemoizedHelpers