# frozen_string_literal: true

RSpec.describe Taxman2024::Bpaf do
  let(:bpaf) { described_class.new(a: a, hd: hd).amount }
  let(:hd) { 0 }

  context "when net income is less than $173_205" do
    let(:a) { 170_000_00 }

    it "equals maximum" do
      expect(bpaf).to eq 15_705_00
    end
  end

  context "when net income is in between $173_205 and $246_752" do
    let(:a) { 200_000_00.to_d }

    it "scales the bpaf down" do
      expect(bpaf).to eq 15_705_00 - ((a - 173_205_00) * (1_549_00.to_d / 73_547_00.to_d))
    end
  end

  context "when net income is over $246_752" do
    let(:a) { 200_000_00 }
    let(:hd) { 50_000_00 }

    it "equals the lowest bpaf amount" do
      expect(bpaf).to eq 14_156_00
    end
  end
end
