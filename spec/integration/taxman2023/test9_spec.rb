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
      taxable_periodic_income: 3_500,
      taxable_non_periodic_income: 0,
      province: "sk"
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

  let(:t) do
    Taxman2023::Td1Input.new(
      federal_personal_amount: 13_727.88,
      provincial_personal_amount: 17_661.00,
      additional_tax_deductions: 0
    )
  end

  let(:c) do
    Taxman2023::CppInput.new(
      pensionable_income_this_period: 3_500,
      ytd_contributions: 3_754.45,
      contribution_months_this_year: 9
    )
  end

  let(:e) do
    Taxman2023::EiInput.new(
      insurable_income_this_period: 3_500,
      employees_ytd_contributions: 1_002.45
    )
  end

  it "matches PDOC's federal tax" do
    expect(calculate[:federal_tax]).to eq 694.80
  end

  it "matches PDOC's provincial tax" do
    expect(calculate[:provincial_tax]).to eq 389.74
  end

  it "matches PDOC's CPP deduction" do
    expect(calculate[:employee_cpp_contribution]).to eq 0
  end

  it "matches PDOC's EI calculation" do
    expect(calculate[:employee_ei_contribution]).to eq 0
  end
end
# rubocop:enable RSpec/FilePath, RSpec/MultipleMemoizedHelpers