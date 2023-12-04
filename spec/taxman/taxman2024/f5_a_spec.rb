# frozen_string_literal: true

# F5A = F5 * ((PI - B)/PI)
RSpec.describe Taxman2024::F5A do
  # We're taking the examples from https://www.canada.ca/en/revenue-agency/services/forms-publications/payroll/t4127-payroll-deductions-formulas/t4127-jan/t4127-jan-payroll-deductions-formulas-computer-programs.html#toc97
  let(:f5a) { described_class.new(pi: pi, b_pensionable: b, f5: f5, f5q: f5q, province: province).amount }

  let(:f5) { 8_93.0 }
  let(:f5q) { 8_30.21 }
  let(:pi) { 960_00.0 }
  let(:province) { "ON" }

  context "when no bonus income" do
    let(:b) { 0 }

    it "is equal to f5" do
      expect(f5a).to eq f5
    end

    context "when province is Quebec" do
      let(:province) { "QC" }

      it "is equal to f5q" do
        expect(f5a).to eq f5q
      end
    end
  end

  context "when pensionable income is zero" do
    let(:b) { 0 }
    let(:pi) { 0 }

    it "is equal to zero" do
      expect(f5a).to be_zero
    end
  end

  context "with pensionable income and a bonus" do
    let(:f5) { 52_08.40 }
    let(:pi) { 5_500_00 }
    let(:b)  { 1_000_00 }

    it "calculates the correct f5a" do
      expect(f5a).to be_within(0.01).of "42_61.42".to_d
    end

    context "when province is Quebec" do
      let(:province) { "QC" }
      let(:f5q) { 48_42.18 }

      it "calculates the correct f5a" do
        expect(f5a).to be_within(0.01).of "39_61.78".to_d
      end
    end
  end
end
