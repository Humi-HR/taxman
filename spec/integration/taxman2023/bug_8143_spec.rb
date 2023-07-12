# frozen_string_literal: true

# rubocop:disable RSpec/FilePath
RSpec.describe Taxman2023::Calculate do
  # NOTE EI EXEMPT ON PDOC
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
      taxable_periodic_income: 3_646.40 + 9.37,
      taxable_non_periodic_income: 0,
      province: "mb"
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
      federal_personal_amount: nil,
      provincial_personal_amount: nil,
      additional_tax_deductions: 0
    )
  end

  let(:c) do
    Taxman2023::CppInput.new(
      pensionable_income_this_period: 3_655.77,
      pensionable_non_periodic_income_this_period: 0,
      ytd_contributions: 1255.37,
      contribution_months_this_year: 12
    )
  end

  # NOTE EI EXEMPT ON PDOC
  let(:e) do
    Taxman2023::EiInput.new(
      insurable_income_this_period: 0,
      employees_ytd_contributions: 0
    )
  end

  it "matches PDOC's federal tax" do
    expect(calculate[:federal_tax]).to eq 516.88
  end

  it "matches PDOC's provincial tax" do
    expect(calculate[:provincial_tax]).to be_within(0.1).of 367.44
  end

  it "matches PDOC's CPP deduction" do
    expect(calculate[:employee_cpp_contribution]).to be_within(0.1).of 209.51
  end

  it "matches PDOC's EI calculation" do
    expect(calculate[:employee_ei_contribution]).to eq 0
  end
end
# rubocop:enable RSpec/FilePath
