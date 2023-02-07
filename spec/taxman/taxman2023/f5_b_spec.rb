# frozen_string_literal: true

# F5B = F5 * (B/PI)
RSpec.describe Taxman2023::F5B do
  # We're taking the examples from https://www.canada.ca/en/revenue-agency/services/forms-publications/payroll/t4127-payroll-deductions-formulas/t4127-jan/t4127-jan-payroll-deductions-formulas-computer-programs.html#toc97
  let(:f5b) { described_class.new(pi: pi, b: b, f5: f5).amount }

  let(:f5) { 52_08.40 }
  let(:pi) { 5_500_00 }
  let(:b)  { 1_000_00 }

  context "with no bonus income" do
    let(:b) { 0 }

    it "is equal to zero" do
      expect(f5b).to be_zero
    end
  end

  context "when pensionable income is zero" do
    let(:b) { 0 }
    let(:pi) { 0 }

    it "is equal to zero" do
      expect(f5b).to be_zero
    end
  end

  context "with pensionable income and a bonus" do
    it "calculates the correct f5b" do
      expect(f5b).to eq "9_46.98".to_d
    end
  end

  context "when all of the income is bonus" do
    let(:b) { pi }

    it "is equal to f5" do
      expect(f5b).to eq f5
    end
  end

  # see https://docs.google.com/spreadsheets/d/1GwlJj9_1ilsRuOV5qPsQY-qFWXqkEEGzeshSq-sgjRg/edit?usp=sharing
  context "when there is a large bonus in the period" do
    let(:b) { 21_619_00 }
    let(:pi) { 3_076_92 + b }
    let(:f5) { 245_61.34 }

    it "matches PDOC/Greg's sheet" do
      expect(f5b).to eq 215_01.19.to_d
    end
  end
end
