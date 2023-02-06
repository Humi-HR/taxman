# frozen_string_literal: true

RSpec.describe Taxman2023::T3 do
  let(:t3) { described_class.new(a: a, hd: hd).amount }
  let(:hd) { 0 }

  context "with no income" do
    let(:a) { 0 }

    it "calculates no taxes" do
      expect(t3).to eq 0
    end
  end

  context "with $54,000 a year income" do
    let(:a) { 54_000_00.to_d }

    it "calculates an annulized tax of $5,067.97" do
      expect(t3).to eq 5_067_97
    end
  end
end
