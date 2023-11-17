# frozen_string_literal: true

RSpec.describe Taxman2024::Calculate do
  let(:calculate) do
    described_class.new(
      period_input: p,
      year_input: y,
      personal_tax_input: t,
      pension_input: c,
      ei_input: e
    ).call
  end

  let(:p) do
    Taxman2024::PeriodInput.new(
      taxable_periodic_income: 2516.66,
      taxable_non_periodic_income: 1000,
      province: "on"
    )
  end

  let(:y) do
    Taxman2024::YearInput.new(
      ytd_bonus: 1000,
      pay_periods: 26,
      f5b_ytd: 0,
      employer_ei_multiple: 1.4
    )
  end

  let(:t) do
    Taxman2024::PersonalTaxDeductionsInput.new(
      federal_personal_amount: 15_000,
      provincial_personal_amount: 11_865
    )
  end

  let(:c) do
    Taxman2024::PensionInput.new(
      pensionable_income_this_period: 3516.66,
      pensionable_non_periodic_income_this_period: 1000,
      ytd_cpp_contributions: 0,
      ytd_qpp_contributions: 0,
      contribution_months_this_year: 12
    )
  end

  let(:e) do
    Taxman2024::EiInput.new(
      insurable_income_this_period: 3500,
      employees_ytd_contributions: 0
    )
  end

  context "when calculating regular taxes" do
    it "matches a" do
      expect(calculate[:a]).to be_within(1).of 64_803_88
    end

    it "matches PDOC's federal tax" do
      expect(calculate[:federal_tax]).to eq 280.17
    end

    it "matches PDOC's provincial tax" do
      expect(calculate[:provincial_tax]).to eq 142.57
    end

    it "matches PDOC's federal tax on bonus" do
      expect(calculate[:federal_tax_on_bonus]).to be_within(0.1).of 201.78
    end

    it "matches PDOC's provincial tax on bonus" do
      expect(calculate[:provincial_tax_on_bonus]).to be_within(0.1).of 90.21
    end

    it "matches PDOC's CPP deduction" do
      expect(calculate[:employee_cpp_contribution]).to eq 201.23
    end

    it "matches PDOC's EI calculation" do
      expect(calculate[:employee_ei_contribution]).to eq 57.05
    end
  end

  context "when calculating the taxes with bonus" do
    it "matches the bonus a" do
      expect(calculate.dig(:taxes_with_bonus, :a)).to be_within(1).of 66_794_26
    end

    it "matches the bonus t3" do
      expect(calculate.dig(:taxes_with_bonus, :t3)).to be_within(1).of 7_683_74
    end
  end

  context "when calculating the bonus taxes without bonus" do
    let(:context) { calculate[:taxes_without_bonus] }

    it "matches the rate" do
      expect(context[:r]).to eq 0.205
    end

    it "matches a" do
      expect(context[:a]).to be_within(1).of 65_803_88
    end

    it "matches i" do
      expect(context[:i]).to eq 2_516_66
    end

    it "matches t3" do
      expect(context[:t3]).to be_within(1).of 7_481_95
    end

    it "matches k" do
      expect(context[:k]).to eq 2_935_00
    end

    it "matches k2" do
      expect(context[:k2_value]).to be_within(0.1).of 61_764.58
    end
  end
end
