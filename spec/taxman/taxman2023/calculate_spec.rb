# frozen_string_literal: true

# rubocop:disable RSpec/MultipleMemoizedHelpers
RSpec.describe Taxman2023::Calculate do
  let(:calculate) do
    described_class.new(
      period_input: p,
      year_input: y,
      td1_input: t,
      cpp_input: c,
      ei_input: e
    )
  end

  context "with $156k, weekly schedule, $1k bonus YTD, $5k bonus current" do
    let(:p) do
      Taxman2023::PeriodInput.new(taxable_periodic_income: 3_000, taxable_non_periodic_income: 5_000, province: "on")
    end

    let(:y) do
      Taxman2023::YearInput.new(
        ytd_bonus: 1000,
        pay_periods: 52,
        f5b_ytd: 9.63,
        employer_ei_multiple: 1.4
      )
    end

    let(:t) { Taxman2023::Td1Input.new }

    let(:c) do
      Taxman2023::CppInput.new(
        pensionable_income_this_period: 8_000,
        ytd_contributions: 0,
        contribution_months_this_year: 12
      )
    end

    let(:e) do
      Taxman2023::EiInput.new(
        insurable_income_this_period: 8_000,
        employees_ytd_contributions: 0
      )
    end

    it "calculates the federal tax owed" do
      expect(calculate.call).to match(
        a_hash_including(federal_tax: 543.84)
      )
    end

    it "calculates the provincial tax owed" do
      expect(calculate.call).to match(
        a_hash_including(provincial_tax: 321.17)
      )
    end

    it "calculates the bonus tax owed" do
      expect(calculate.call).to match(
        a_hash_including(total_bonus_tax: 2_226.18)
      )
    end

    it "calculates the employee cpp contribution" do
      expect(calculate.call).to match(
        a_hash_including(employee_cpp_contribution: 472.0)
      )
    end

    it "calculates the employer cpp contribution" do
      expect(calculate.call).to match(
        a_hash_including(employer_cpp_contribution: 472.0)
      )
    end

    it "calculates the employee ei contribution" do
      expect(calculate.call).to match(
        a_hash_including(employee_ei_contribution: 130.4)
      )
    end

    it "calculates the employer ei contribution" do
      expect(calculate.call).to match(
        a_hash_including(employer_ei_contribution: 182.56)
      )
    end
  end

  context "with $80k, biweekly schedule, $21,619 current bonus" do
    let(:p) do
      Taxman2023::PeriodInput.new(
        taxable_periodic_income: 3_076.92,
        taxable_non_periodic_income: 21_619, province: "sk"
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

    let(:t) { Taxman2023::Td1Input.new }

    let(:c) do
      Taxman2023::CppInput.new(
        pensionable_income_this_period: 24_695.92,
        ytd_contributions: 0,
        contribution_months_this_year: 12
      )
    end

    let(:e) do
      Taxman2023::EiInput.new(
        insurable_income_this_period: 24_695.92,
        employees_ytd_contributions: 0
      )
    end

    it "calculates the federal tax owed" do
      expect(calculate.call).to match(
        a_hash_including(federal_tax: 393.38)
      )
    end

    it "calculates the federal bonus tax owed" do
      expect(calculate.call).to match(
        a_hash_including(federal_tax_on_bonus: 4_387.82)
      )
    end
  end

  context "with $80k, biweekly schedule, td_offset & tdp_offseet of $1,000" do
    let(:p) do
      Taxman2023::PeriodInput.new(
        taxable_periodic_income: 3_076.92,
        taxable_non_periodic_income: 0, province: "sk"
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
        federal_personal_amount_offset: 1_000,
        provincial_personal_amount_offset: 1_000
      )
    end

    let(:c) do
      Taxman2023::CppInput.new(
        pensionable_income_this_period: 3_076.92,
        ytd_contributions: 0,
        contribution_months_this_year: 12
      )
    end

    let(:e) do
      Taxman2023::EiInput.new(
        insurable_income_this_period: 3_076.92,
        employees_ytd_contributions: 0
      )
    end

    it "calculates the federal tax owed" do
      expect(calculate.call).to match(
        a_hash_including(federal_tax: 387.85)
      )
    end

    it "calculates the provincial tax owed" do
      expect(calculate.call).to match(
        a_hash_including(provincial_tax: 250.68)
      )
    end
  end
end
# rubocop:enable RSpec/MultipleMemoizedHelpers
