# frozen_string_literal: true

RSpec.describe Taxman2023::C do
  subject(:c) { described_class.new(p: p, pm: pm, d: d, i: i, b: b).amount }

  let(:p) { 12 }
  let(:pm) { 12 }
  let(:b) { 0 }

  context "when the employee has already reached the cpp maximum for the year" do
    let(:d) { Taxman2023::C::CPP_MAX }
    let(:i) { 4_000_00 }

    it "calculates zero cpp contribution for this period" do
      expect(c).to be_zero
    end
  end

  context "when the employee will meet and exceed the maximum this period" do
    let(:d) { Taxman2023::C::CPP_MAX - 100_00 }
    let(:i) { 4_000_00 }

    it "calculates a cpp contribution of the remaining room" do
      expect(c).to eq 100_00
    end
  end

  context "when the employee has zero income in the period" do
    let(:d) { 0 }
    let(:i) { 0 }

    it "calculates zero cpp contribution for the period" do
      expect(c).to be_zero
    end
  end

  context "with a $54k salary monthly and a $1k bonus" do
    let(:d) { 0 }
    let(:i) { 5_500_00 }

    it "matches the PDOC expectation" do
      expect(c).to be_within(0.01).of 309_89.58.to_d
    end
  end
end
