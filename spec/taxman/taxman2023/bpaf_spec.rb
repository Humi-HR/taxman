# frozen_string_literal: true

RSpec.describe Taxman2023::Bpaf do
  let(:bpaf) { described_class.new(a: a, hd: hd).amount }
  let(:hd) { 0 }

  context "when net income is less than $165_430" do
    let(:a) { 100_000_00 }

    it "equals fifteen thousand" do
      expect(bpaf).to eq 15_000_00
    end
  end

  context "when net income is in between $165_430 and $235_675" do
    let(:a) { 200_000_00.to_d }

    it "scales the bpaf down" do
      expect(bpaf).to eq 15_000_00 - ((a - 165_430_00) * (1_479_00.to_d / 70_245_00.to_d))
    end
  end

  context "when net income is over $235_675" do
    let(:a) { 200_000_00 }
    let(:hd) { 50_000_00 }

    it "equals the lowest bpaf amount" do
      expect(bpaf).to eq 13_521_00
    end
  end
end
