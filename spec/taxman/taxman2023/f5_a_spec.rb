# frozen_string_literal: true

# F5A = F5 * ((PI - B)/PI)
RSpec.describe Taxman2023::F5A do
  # We're taking the examples from https://www.canada.ca/en/revenue-agency/services/forms-publications/payroll/t4127-payroll-deductions-formulas/t4127-jan/t4127-jan-payroll-deductions-formulas-computer-programs.html#toc97
  let(:f5a) { described_class.new(pi: pi, b: b, f5: f5).amount }

  let(:f5) { 8_93.0 }
  let(:pi) { 960_00.0 }

  context "when no bonus income" do
    let(:b) { 0 }

    it "is equal to f5" do
      expect(f5a).to eq f5
    end
  end

  context "when pensionable income is zero" do
    let(:b) { 0 }
    let(:pi) { 0 }

    it "is equal to zero" do
      expect(f5a).to eq 0
    end
  end

  context "with pensionable income and a bonus" do
    let(:f5) { 52_08.40 }
    let(:pi) { 5_500_00 }
    let(:b)  { 1_000_00 }

    it "calculates the correct f5a" do
      expect(f5a).to eq "42_61.42".to_d
    end
  end
end
