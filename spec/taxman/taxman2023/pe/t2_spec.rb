# frozen_string_literal: true

RSpec.describe Taxman2023::Pe::T2 do
  let(:t2) { described_class.new(a: a, t4: t4).amount }
  let(:a) { 123_45 }

  context "when T4 is less than the threshold ($12,500)" do
    let(:t4) { 10_000_00 }

    it "has no surtax" do
      expect(t2).to eq t4
    end
  end

  context "when T4 is greater than the threshold" do
    let(:t4) { 12_500_00.to_d + surplus }
    let(:surplus) { 15_000_00 }

    it "has a ten percent surtax on the amount over the threshold" do
      expect(t2).to eq (0.1 * surplus) + t4
    end
  end
end
